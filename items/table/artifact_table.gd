extends StaticBody2D
@onready var label: Label = $Label

func _ready() -> void:
		label.visible = false
		z_index = -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		GlobalScript.current_pedestal = self
		GlobalScript.on_pedestal = true
		label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		GlobalScript.current_pedestal = null
		GlobalScript.on_pedestal = false
		label.visible = false
