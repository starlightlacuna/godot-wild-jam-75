class_name ChoiceData
extends Resource

static var Tags: Dictionary = {
	CONTINUE = "CONTINUE",
	TEST_1 = "TEST_1",
	TEST_2 = "TEST_2",
	DAY1_EXCITED = "DAY1_EXCITED",
	DAY1_NERVOUS = "DAY1_NERVOUS"
}

@export var choice_tag: String

## Text that will be appended to the journal entry when the player selects this choice.
@export var text: String

## Text that is shown in the ChoiceButton.
@export var button_text: String

## Effects on the game world that will be applied when the player selects this choice.
@export var effects: Array[ChoiceEffect]

## Conditions that must be fulfilled before this choice will be presented to the player.
@export var requirements: Array[Requirement]
