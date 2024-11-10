extends Node

const starting_journal_entry: JournalEntryData = preload("res://Data/Day 1/Entries/day1_1.tres")

var choice_history: Array[ChoiceData] = []
var current_entry: JournalEntryData = starting_journal_entry

func _ready() -> void:
	pass

func append_choice(data: ChoiceData) -> void:
	choice_history.append(data)
	# TODO: Apply effects of the choice?

## Updates current_entry. Returns true if the next entry should be appended to the current journal
## label string. If false, we take the player to the next day.
## If next_entry_flag is true, we move to current_entry.next_entry.
func get_next_journal_entry(next_entry_flag: bool) -> bool:
	if next_entry_flag:
		current_entry = current_entry.next_entry
		return true
	
	match choice_history[-1].choice_tag:
		ChoiceData.Tags.DAY1_NERVOUS:
			current_entry = preload("res://Data/Day 1/Entries/day1_2_nervous.tres")
			return true
		ChoiceData.Tags.DAY1_EXCITED:
			current_entry = preload("res://Data/Day 1/Entries/day1_2_excited.tres")
			return true
		ChoiceData.Tags.CONTINUE:
			return true
	return false
