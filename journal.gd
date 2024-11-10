class_name Journal
extends CenterContainer

@export var journal_entry_override: JournalEntryData

@onready var choice_container: HFlowContainer = %ChoiceContainer
@onready var journal_label: JournalLabel = %JournalLabel

const choice_button_scene: PackedScene = preload("res://UI/choice_button.tscn")

var choice_made: bool = false

func _ready() -> void:
	clear_choices()
	if journal_entry_override:
		JournalManager.current_journal_entry = journal_entry_override
	
	journal_label.initialize(JournalManager.current_entry.text)
	journal_label.start_text_advance()

func _on_journal_label_donezo() -> void:
	if choice_made:
		var has_next_entry: bool = JournalManager.get_next_journal_entry()
		if not has_next_entry:
			# TODO: Move to end of day summary?
			return
		journal_label.initialize(JournalManager.current_entry.text)
		journal_label.start_text_advance()
	else:
		show_choices()

func _on_choice_button_pressed(choice_data: ChoiceData) -> void:
	# TODO - Add choice selection animation.
	clear_choices()
	journal_label.append_choice_text(choice_data.text + "\n")
	choice_made = true
	JournalManager.append_choice(choice_data)

func clear_choices() -> void:
	for child in choice_container.get_children():
		child.queue_free()

func show_choices() -> void:
	var choices: Array[ChoiceData] = JournalManager.current_entry.choices
	for choice_data in choices:
		var data: ChoiceData = choice_data
		var new_button: ChoiceButton = choice_button_scene.instantiate()
		new_button.initialize(data)
		new_button.pressed.connect(_on_choice_button_pressed.bind(data))
		choice_container.add_child(new_button)
	
