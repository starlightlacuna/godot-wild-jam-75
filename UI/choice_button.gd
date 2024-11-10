class_name ChoiceButton
extends Button

var choice_tag: String

func initialize(data: ChoiceData) -> void:
	choice_tag = data.choice_tag
	set_text(data.text)
