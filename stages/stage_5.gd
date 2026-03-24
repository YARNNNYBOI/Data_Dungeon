extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:"res://character/final_boss.tscn"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/main_area.tscn")
