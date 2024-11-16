class_name TextWithRequirements
extends Resource

@export_multiline var text: String
@export var requirements: Array[Requirement]
@export var world_key: String

func are_requirements_fulfilled() -> bool:
	var fulfilled = true
	for requirement in requirements:
		fulfilled = fulfilled and requirement.is_fulfilled()
	return fulfilled
