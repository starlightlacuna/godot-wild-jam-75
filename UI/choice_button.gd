class_name ChoiceButton
extends Button

var journal_tag: String

func initialize(data: ChoiceData) -> void:
	journal_tag = data.journal_tag
	set_text(data.text)
