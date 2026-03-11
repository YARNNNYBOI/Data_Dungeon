extends Node2D

@export var health_gain : int
@export var speed_gain : int


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("potion used")
	if body.is_in_group("players"):
		if GlobalScript.health >= 100:
			pass
		else:
			GlobalScript.health += health_gain
		GlobalScript.speed += speed_gain
		print("speed ", GlobalScript.speed, ",health ", GlobalScript.health)
	queue_free()
