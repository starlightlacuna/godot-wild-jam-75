class_name Requirement
extends Resource

enum Operator { EQUALS, GREATER_THAN, GREATER_THAN_OR_EQUALS, LESS_THAN, LESS_THAN_OR_EQUALS }

@export var key: String
@export var value: String
@export var type: Variant.Type
@export var operator: Operator

func is_fulfilled(world_override: Dictionary = {}) -> bool:
	var world_dictionary: Dictionary
	if not world_override.is_empty():
		world_dictionary = world_override
	else:
		world_dictionary = JournalManager.world
	
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
			return world_dictionary[key] == typed_value
		Operator.GREATER_THAN:
			return world_dictionary[key] > typed_value
		Operator.GREATER_THAN_OR_EQUALS:
			return world_dictionary[key] >= typed_value
		Operator.LESS_THAN:
			return world_dictionary[key] < typed_value
		Operator.LESS_THAN_OR_EQUALS:
			return world_dictionary[key] <= typed_value
		_:
			return false
