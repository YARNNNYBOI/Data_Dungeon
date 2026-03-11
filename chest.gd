extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var control: Control = $Control

@onready var chest_open = preload("res://stages/tilesets/chest_open.png")
@export var item : PackedScene

@export var artifact_name : String
@export var artifact_position : Vector2
@export var artifact_texture : CompressedTexture2D
@export var quanorquan : String

@export var title_text : String
@export var description_text : String

var artifact_instance : Node2D

@onready var isTreasureCollected = false

func _ready() -> void:
	sprite_2d.visible = false
	control.visible = false
	
func show_chest():
	sprite_2d.visible = true
	control.visible = true
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if sprite_2d.visible and control.visible:
			sprite_2d.texture = chest_open
			if !isTreasureCollected:
				artifact_instance = item.instantiate()
				artifact_instance.item_name = artifact_name
				artifact_instance.qualorquan = quanorquan
				artifact_instance.title_text = title_text
				artifact_instance.description_text = description_text
				artifact_instance.get_node("Sprite2D").z_index = 0
				artifact_instance.get_node("Sprite2D").texture = artifact_texture
				artifact_instance.global_position = Vector2(global_position.x, global_position.y + 30)
				get_tree().current_scene.add_child(artifact_instance)
				isTreasureCollected = true
