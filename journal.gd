class_name Journal
extends CenterContainer

const choice_button_scene: PackedScene = preload("res://UI/choice_button.tscn")

@onready var choice_container: HFlowContainer = %ChoiceContainer
@onready var journal_label: RichTextLabel = %JournalLabel

var next_choices: Array

func _ready() -> void:
	clear_choices()
	next_choices = [load("res://Data/test1.tres"), load("res://Data/test2.tres")]

func _on_journal_label_donezo() -> void:
	show_choices(next_choices)

func _on_choice_button_pressed(journal_tag: String) -> void:
	# TODO - Add choice selection animation.
	clear_choices()
	match journal_tag:
		"TEST_1":
			journal_label.append_choice_text("\nYou ate the cheese.")
			next_choices.clear()
		"TEST_2":
			journal_label.append_choice_text("\nYou ignored the cheese.")
			next_choices.clear()

func clear_choices() -> void:
	for child in choice_container.get_children():
		child.queue_free()

func show_choices(choices: Array) -> void:
	for choice_data in choices:
		var new_button: ChoiceButton = choice_button_scene.instantiate()
		new_button.initialize(choice_data as ChoiceData)
		new_button.pressed.connect(_on_choice_button_pressed.bind(choice_data.journal_tag))
		choice_container.add_child(new_button)
	
