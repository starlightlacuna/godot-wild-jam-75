class_name Journal
extends CenterContainer

enum Mode { JOURNAL_ENTRY, INTERSEQUENCE }

@export var journal_entry_override: JournalEntryData

@onready var choice_container: HFlowContainer = %ChoiceContainer
@onready var entry_label: JournalLabel = %EntryLabel
@onready var journal_entry_container: VBoxContainer = $JournalEntryContainer
@onready var intersequence_container: HBoxContainer = $IntersequenceContainer
@onready var sequence_button_container: VBoxContainer = %SequenceButtonContainer

const choice_button_scene: PackedScene = preload("res://UI/choice_button.tscn")
const continue_button_data: ChoiceData = preload("res://Data/continue.tres")

var choice_made: bool = false
var current_entry: JournalEntryData

func _ready() -> void:
	for child in sequence_button_container.get_children():
		var sequence_button: SequenceButton = child
		sequence_button.pressed.connect(_on_sequence_button_pressed.bind(sequence_button.sequence_tag))
	clear_choices()
	if journal_entry_override:
		current_entry = journal_entry_override
	else:
		current_entry = JournalManager.get_sequence_start("prologue")
	_start_current_entry()

func _on_entry_label_donezo() -> void:
	if choice_made:
		var has_next_entry: bool = true if current_entry.next_entry else false
		if has_next_entry:
			current_entry = current_entry.next_entry
			entry_label.append_text(_get_current_entry_text())
			entry_label.start_text_advance()
		else:
			# TODO: Move to Intersequence Mode (Perhaps not needed?)
			# We're already doing that in the continue button handler.
			pass
		choice_made = false
	else:
		show_choices()

func _on_choice_button_pressed(choice_data: ChoiceData) -> void:
	# TODO (REACH): Add choice selection animation.
	clear_choices()
	entry_label.append_choice_text(choice_data.text + "\n")
	JournalManager.apply_choice_effects(choice_data)
	choice_made = true

func _on_continue_button_pressed() -> void:
	clear_choices()
	if current_entry.next_entry:
		current_entry = current_entry.next_entry
		_start_current_entry()
	else:
		print("SEQUENCE COMPLETE. MOVING TO INTERSEQUENCE MODE.")
		JournalManager.sequences[current_entry.sequence_tag].complete = true
		_change_mode(Mode.INTERSEQUENCE)

func _on_sequence_button_pressed(sequence_tag: String) -> void:
	current_entry = JournalManager.get_sequence_start(sequence_tag)
	_start_current_entry()

func _change_mode(mode: Mode) -> void:
	match mode:
		Mode.JOURNAL_ENTRY:
			journal_entry_container.show()
			intersequence_container.hide()
		Mode.INTERSEQUENCE:
			journal_entry_container.hide()
			intersequence_container.show()
			var available_sequence_keys: Array[String] = JournalManager.get_available_sequences()
			for child in sequence_button_container.get_children():
				var sequence_button: SequenceButton = child
				if available_sequence_keys.has(sequence_button.sequence_tag):
					sequence_button.show()
				else:
					sequence_button.hide()

func _get_current_entry_text() -> String:
	var text: String
	for text_with_requirements in current_entry.texts:
		if text_with_requirements.are_requirements_fulfilled():
			text = text_with_requirements.text
			break
	return text

func _start_current_entry() -> void:
	# TODO: Replay the player's choice history.
	_change_mode(Mode.JOURNAL_ENTRY)
	var text: String = _get_current_entry_text()
	entry_label.initialize(text)
	entry_label.start_text_advance()

func _clear_entry_label() -> void:
	entry_label.clear()

func clear_choices() -> void:
	for child in choice_container.get_children():
		child.queue_free()

func show_choices() -> void:
	# By default, we add a continue button so we can load the next entry in the sequence.
	if current_entry.choices.is_empty():
		var continue_button: ChoiceButton = choice_button_scene.instantiate()
		continue_button.initialize(continue_button_data)
		continue_button.pressed.connect(_on_continue_button_pressed)
		choice_container.add_child(continue_button)
		return
		
	var choices: Array[ChoiceData] = current_entry.choices
	for choice_data in choices:
		var data: ChoiceData = choice_data
		var new_button: ChoiceButton = choice_button_scene.instantiate()
		new_button.initialize(data)
		new_button.pressed.connect(_on_choice_button_pressed.bind(data))
		choice_container.add_child(new_button)
	
