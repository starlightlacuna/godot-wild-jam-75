class_name JournalEntryData
extends Resource

## Text to display to the player.
@export_multiline var text: String

## Choices to present to the player after all text is loaded.
@export var choices: Array[ChoiceData]

## The next entry in the chain. Only used when the entry has the "Continue" choice.
@export var next_entry: JournalEntryData

#
#class_name JournalEntryData
#extends Resource
#
#const TEXT: String = "text"
#const CHOICES: String = "choices"
#
#var content: Dictionary = {}
#
### Must be overridden!
#func get_next_content_node() -> void:
	#printerr("DATA NOT OVERRIDEN")
