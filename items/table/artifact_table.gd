extends StaticBody2D
@onready var label: Label = $Label
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var empty_table = preload("res://items/table/table.png")
@onready var full_table = preload("res://items/table/tablewitems.png")
@export var research_type : String
@export var table_bool: bool

func _ready() -> void:
		sprite_2d.texture = empty_table
		label.visible = false
		z_index = -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		GlobalScript.current_pedestal = self
		GlobalScript.isTableOneSelected = table_bool
		GlobalScript.tableType = research_type
		GlobalScript.on_pedestal = true
		label.visible = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		GlobalScript.current_pedestal = null
		GlobalScript.on_pedestal = false
		GlobalScript.isTableOneSelected = table_bool
		GlobalScript.tableType = ""
		label.visible = false
