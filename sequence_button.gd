class_name SequenceButton
extends Button

@export var sequence_tag: String

func _ready() -> void:
	assert(sequence_tag, "Sequence Tag not set!")
