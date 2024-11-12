class_name TextWithRequirements
extends Resource

@export var text: String
@export var requirements: Array[Requirement]

func are_requirements_fulfilled() -> bool:
	var fulfilled = true
	for requirement in requirements:
		fulfilled = fulfilled and requirement.is_fulfilled()
	return fulfilled
