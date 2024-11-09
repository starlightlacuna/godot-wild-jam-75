class_name JournalLabel
extends RichTextLabel

## How many characters to advance per second
@export var text_speed: float = 10.0

@onready var timer: Timer = $TextAdvanceTimer

func _ready() -> void:
	set_visible_characters(0)
	timer.set_wait_time(1.0 / text_speed)

func _on_text_advance_timer_timeout() -> void:
	if get_visible_characters() < get_text().length():
		set_visible_characters(get_visible_characters() + 1)
		timer.start()
