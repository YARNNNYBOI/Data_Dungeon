extends Control


func _on_castro_pressed() -> void:
	GlobalScript.weapon_number = 0
	go_to_world()

func _on_ely_pressed() -> void:
	GlobalScript.weapon_number = 1
	go_to_world()

func _on_faith_pressed() -> void:
	GlobalScript.weapon_number = 2
	go_to_world()
	
func _on_tine_pressed() -> void:
	GlobalScript.weapon_number = 3
	go_to_world()

func _on_clark_pressed() -> void:
	GlobalScript.weapon_number = 4
	go_to_world()

func _on_rose_pressed() -> void:
	GlobalScript.weapon_number = 5
	go_to_world()

func go_to_world():
	get_tree().change_scene_to_file("res://stages/main_area.tscn")
