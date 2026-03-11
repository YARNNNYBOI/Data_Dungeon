extends Control
@onready var start: Button = $MarginContainer/CenterContainer/VBoxContainer/Start
@onready var exit: Button = $MarginContainer/CenterContainer/VBoxContainer/Exit


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://stages/character_select.tscn")


func _on_exit_pressed() -> void:
	print("your not going anywhere")
