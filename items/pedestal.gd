extends StaticBody2D
@onready var label: Label = $CollisionShape2D/Label

@onready var player

@export var pedestal : String

func _ready() -> void:
	add_to_group(str(pedestal))
	print(get_groups())
	label.visible = false
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = body
		label.visible = true
		GlobalScript.on_pedestal = true
		GlobalScript.current_pedestal = pedestal


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = null
		label.visible = false
		GlobalScript.on_pedestal = false
		GlobalScript.current_pedestal = ""

func _on_button_pressed() -> void:
	print("bing")
