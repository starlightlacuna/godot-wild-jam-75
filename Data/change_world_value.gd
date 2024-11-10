class_name ChangeWorldValue
extends ChoiceEffect

enum Operation { SET, ADD, SUBTRACT }

@export var key: String
@export var value: String
@export var type: Variant.Type
@export var operation: Operation

func apply() -> void:
	if key == null or value == null or type == TYPE_NIL:
		printerr("Change World Value not initialized properly!")
		return
	
	# TODO: Add checks for type safety
	var typed_value
	match type:
		TYPE_BOOL:
			typed_value = true if value == "true" else false
		TYPE_INT:
			typed_value = value.to_int()
		TYPE_FLOAT:
			typed_value = value.to_float()
		TYPE_STRING:
			typed_value = value
	
	match operation:
		Operation.SET:
			JournalManager.world[key] = typed_value
		Operation.ADD:
			JournalManager.world[key] += typed_value
		Operation.SUBTRACT:
			JournalManager.world[key] -= typed_value
