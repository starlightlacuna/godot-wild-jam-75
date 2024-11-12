class_name Requirement
extends Resource

enum Operator { EQUALS, GREATER_THAN, GREATER_THAN_OR_EQUALS, LESS_THAN, LESS_THAN_OR_EQUALS }

@export var key: String
@export var value: String
@export var type: Variant.Type
@export var operator: Operator

func is_fulfilled() -> bool:
	# TODO (REACH): Add checks for type safety
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
	
	match operator:
		Operator.EQUALS:
			return JournalManager.world[key] == typed_value
		Operator.GREATER_THAN:
			return JournalManager.world[key] > typed_value
		Operator.GREATER_THAN_OR_EQUALS:
			return JournalManager.world[key] >= typed_value
		Operator.LESS_THAN:
			return JournalManager.world[key] < typed_value
		Operator.LESS_THAN_OR_EQUALS:
			return JournalManager.world[key] <= typed_value
		_:
			return false
