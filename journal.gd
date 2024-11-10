class_name Journal
extends CenterContainer

@export var journal_entry_override: JournalEntryData

@onready var choice_container: HFlowContainer = %ChoiceContainer
@onready var entry_label: JournalLabel = %EntryLabel

const choice_button_scene: PackedScene = preload("res://UI/choice_button.tscn")
const continue_button_data: ChoiceData = preload("res://Data/continue.tres")

var choice_made: bool = false
var current_entry: JournalEntryData

func _ready() -> void:
	clear_choices()
	#if journal_entry_override:
		#JournalManager.current_journal_entry = journal_entry_override
	
	current_entry = JournalManager.get_next_sequence_start()
	_start_current_sequence()

func _on_entry_label_donezo() -> void:
	if choice_made:
		var has_next_entry: bool = true if JournalManager.current_entry.next_entry else false
		var continue_day: bool = JournalManager.get_next_journal_entry(has_next_entry)
		if not continue_day:
			# TODO: Move to end of day summary?
			return
		entry_label.append_text(JournalManager.current_entry.text)
		entry_label.start_text_advance()
		choice_made = false
	else:
		show_choices()

func _on_choice_button_pressed(choice_data: ChoiceData) -> void:
	# TODO - Add choice selection animation.
	clear_choices()
	if choice_data.choice_tag != ChoiceData.Tags.CONTINUE:
		entry_label.append_choice_text(choice_data.text + "\n")
		JournalManager.append_choice(choice_data)
	else:
		# TODO: Handle continues!
		pass
	choice_made = true

func _on_continue_button_pressed() -> void:
	clear_choices()
	if current_entry.next_entry:
		current_entry = current_entry.next_entry
		_start_current_sequence()
		
	else:
		# TODO: Move to the next sequence.
		print("SEQUENCE COMPLETE. MOVING TO INTERSEQUENCE MODE.")
		pass

func _start_current_sequence() -> void:
	entry_label.initialize(current_entry.text)
	entry_label.start_text_advance()

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
		
	var choices: Array[ChoiceData] = JournalManager.current_entry.choices
	for choice_data in choices:
		var data: ChoiceData = choice_data
		var new_button: ChoiceButton = choice_button_scene.instantiate()
		new_button.initialize(data)
		new_button.pressed.connect(_on_choice_button_pressed.bind(data))
		choice_container.add_child(new_button)
	
