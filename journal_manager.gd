extends Node

#region Old System
#const starting_journal_entry: JournalEntryData = preload("res://Data/Day 1/Entries/day1_1.tres")
#const flags: Dictionary = {
	#day1_excited = false,
	#day1_nervous = false
#}
#
#var choice_history: Array[ChoiceData] = []
#var current_entry: JournalEntryData = starting_journal_entry

#func _ready() -> void:
	#pass
#
#func append_choice(data: ChoiceData) -> void:
	#choice_history.append(data)
	## TODO: Apply effects of the choice?
#
### Updates current_entry. Returns true if the next entry should be appended to the current journal
### label string. If false, we take the player to the next day.
### If next_entry_flag is true, we move to current_entry.next_entry.
#func get_next_journal_entry(next_entry_flag: bool) -> bool:
	#if next_entry_flag:
		#current_entry = current_entry.next_entry
		#return true
	#
	#match choice_history[-1].choice_tag:
		#ChoiceData.Tags.DAY1_NERVOUS:
			#current_entry = preload("res://Data/Day 1/Entries/day1_2_nervous.tres")
			#return true
		#ChoiceData.Tags.DAY1_EXCITED:
			#current_entry = preload("res://Data/Day 1/Entries/day1_2_excited.tres")
			#return true
		#ChoiceData.Tags.CONTINUE:
			#return true
	#return false

#endregion Old System

#const START: String = "start"
#const TEXT: String = "text"
#const EFFECTS: String = "effects"

## This contains all the game's state variables. It's referenced by journal entries and choices.
var world: Dictionary = {
	"day1_excited": false
}

var sequences: Dictionary = {
	"prologue": {
		"start": preload("res://Data/Prologue/prologue1.tres"),
		"complete": false,
		"choice_history": []
	}
}

func _ready() -> void:
	#print(content.day1.START.TEXT)
	pass

func get_sequence_start(key: String) -> JournalEntryData:
	return sequences[key].start

func is_sequence_complete(key: String) -> bool:
	if not sequences.has(key):
		printerr("Sequences dictionary doesn't have key: " + key)
		return false
	return sequences[key].complete
