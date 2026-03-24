extends StaticBody2D
@onready var label: Label = $CollisionShape2D/Label
@onready var player
@onready var artifact_text: Sprite2D = $artifact_text

@export var pedestal_name : String
@export var research_type : String

func _ready() -> void:
	label.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = body
		label.visible = true
		GlobalScript.on_pedestal = true
		GlobalScript.current_pedestal = pedestal_name
		print("in", GlobalScript.current_pedestal)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = null
		label.visible = false
		GlobalScript.on_pedestal = false
		GlobalScript.current_pedestal = null
		print("out", GlobalScript.current_pedestal)
