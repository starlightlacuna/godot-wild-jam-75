extends Node

const starting_journal_entry: JournalEntryData = preload("res://Data/Day 1/day1_1.tres")

var choice_history: Array = []
var current_entry: JournalEntryData = preload("res://Data/Day 1/day1_1.tres")

func _ready() -> void:
	pass

func append_choice(data: ChoiceData) -> void:
	choice_history.append(data)
	# TODO: Apply effects of the choice?

func get_next_journal_entry() -> bool:
	return false
