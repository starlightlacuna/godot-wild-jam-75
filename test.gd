extends Control

@export var color1: Color
@export var color2: Color
@export var value: int = 0
@export var stat_max: int = 5


func _process(delta: float) -> void:
	var lerp_weight: float = clamp((float(value) + 4.0) / 8.0, 0.0, 8.0)
	var color_string: String = color1.lerp(color2, lerp_weight).to_html(false)
	%TestLabel.clear()
	%TestLabel.append_text("[color=#%s]TEST STRING[/color]" % color_string)
	
