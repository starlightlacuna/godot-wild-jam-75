extends Node

## This contains all the game's state variables. It's referenced by journal entries and choices.
var world: Dictionary = {
	"player.attitude": 1,
	"player.esprit_de_corps": 0,
}

var sequences: Dictionary = {
	"prologue": {
		"start": preload("res://Data/Prologue/prologue1.tres"),
		"complete": false,
		"choice_history": [],
		"next_sequence": "day1"
	},
	"day1": {
		"start": preload("res://Data/Day 1/Entries/day1_1.tres"),
		"complete": false,
		"choice_history": [],
		"next_sequence": "day2"
	},
	"day2": {
		"start": null,
		"complete": false,
		"choice_history": [],
		"next_sequence": "day3"
	},
	"day3": {
		"start": null,
		"complete": false,
		"choice_history": [],
		"next_sequence": ""
	}
}

func _ready() -> void:
	pass
	
func apply_choice_effects(data: ChoiceData) -> void:
	for effect in data.effects:
		effect.apply()

func get_sequence_start(key: String) -> JournalEntryData:
	return sequences[key].start

func get_available_sequences() -> Array[String]:
	var output: Array[String] = []
	for key in sequences:
		var sequence_dict: Dictionary = sequences[key]
		if sequence_dict.complete:
			if not output.has(key):
				output.append(key)
			if not sequence_dict.next_sequence.is_empty() and not output.has(sequence_dict.next_sequence):
				output.append(sequence_dict.next_sequence)
	return output

func is_sequence_complete(key: String) -> bool:
	if not sequences.has(key):
		printerr("Sequences dictionary doesn't have key: " + key)
		return false
	return sequences[key].complete
