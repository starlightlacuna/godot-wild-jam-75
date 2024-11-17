class_name JournalLabel
extends RichTextLabel

## Emitted when the text is finished loading. Courtesy of YourWalkerEx.
signal donezo

## How many characters to advance per second
@export var text_speed: float = 10.0

@onready var timer: Timer = $TextAdvanceTimer

func _ready() -> void:
	## Set the timer wait time
	initialize("", 0.0)

func _on_text_advance_timer_timeout() -> void:
	if get_visible_characters() < get_total_character_count():
		set_visible_characters(get_visible_characters() + 1)
		timer.start()
	else:
		donezo.emit()

func append_choice_text(p_text: String) -> void:
	append_text("[color=#C7CFE9][outline_size=4][outline_color=#18213e]%s[/outline_color][/outline_size][/color]" % p_text)
	timer.start()

func initialize(p_text: String = "", p_text_speed: float = 0.0) -> void:
	if not p_text.is_empty():
		# TODO: Check the Godot repository issues for RichTextLabel.set_text() 
		# not clearing the tag stack prior to setting the text.
		clear()
		append_text(p_text)
		set_visible_characters(0)
	if p_text_speed > 0.0:
		text_speed = p_text_speed
	timer.set_wait_time(1.0 / text_speed)

func start_text_advance() -> void:
	timer.start()
