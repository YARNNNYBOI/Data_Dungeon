extends StaticBody2D
@onready var label: Label = $CollisionShape2D/Label

@onready var player

func _ready() -> void:
	label.visible = false
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = body
		label.visible = true
		GlobalScript.on_pedestal = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = null
		label.visible = false
		GlobalScript.on_pedestal = true


func _on_button_pressed() -> void:
	print("bing")
