extends Control

@export var color1: Color
@export var color2: Color
@export var value: int = 0
@export var stat_max: int = 5
#@export var sound_effect: SoundEffectData
@export_category("Audio 1")
@export var audio_stream: AudioStream
@export_range(-80, 24) var volume_override: float = 0
@export_category("Audio 2")
@export var audio_stream_2: AudioStream
@export_range(-80, 24) var volume_override_2: float = 0

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _process(_delta: float) -> void:
	var lerp_weight: float = clamp(remap(float(value), -3.0, 3.0, 0.0, 1.0), 0.0, 1.0)
	var color_string: String = color1.lerp(color2, lerp_weight).to_html(false)
	%TestLabel.clear()
	%TestLabel.append_text("[color=#%s][outline_size=4]TEST STRING[/outline_size][/color]" % color_string)

func _on_test_audio_button_pressed() -> void:
	audio_stream_player.set_stream(audio_stream)
	audio_stream_player.set_volume_db(volume_override)
	audio_stream_player.play()

func _on_test_audio_button_2_pressed() -> void:
	audio_stream_player.set_stream(audio_stream_2)
	audio_stream_player.set_volume_db(volume_override_2)
	audio_stream_player.play()
