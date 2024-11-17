class_name MainMenu
extends Control

@onready var menu_container: VBoxContainer = %MenuContainer
@onready var credits_container: VBoxContainer = %CreditsContainer

func _ready() -> void:
	credits_container.hide()
	menu_container.show()

func _on_credits_back_button_pressed() -> void:
	credits_container.hide()
	menu_container.show()

func _on_credits_button_pressed() -> void:
	credits_container.show()
	menu_container.hide()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://journal.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
