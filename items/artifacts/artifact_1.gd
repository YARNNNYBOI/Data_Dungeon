extends Node2D
class_name artifact

@onready var isPlayerinArea = false
@onready var control: Control = $Control
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var item_name : String
@export var artifact_text : CompressedTexture2D
@export var qualorquan : String
@export var title_text : String
@export var description_text : String
@export var type_text : String
@export var size : Vector2

@onready var player
@onready var show_info = false



func _ready() -> void:
	add_to_group(qualorquan)
	set_meta("item_name", item_name)
	isPlayerinArea = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and isPlayerinArea:
		if control.visible:
			GlobalScript.player_artifacts[item_name] = {
				"path" : sprite_2d.texture,
				"type" : qualorquan}
			if show_info:
				check_body(player)
			if get_tree().current_scene.has_method("check_artifact_status"):
				get_tree().current_scene.collected_artifact += 1
				get_tree().current_scene.check_artifact_status()
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		show_info = true
		player = body
		isPlayerinArea = true
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		isPlayerinArea = false

func check_body(body:Node2D):
	if body.is_in_group("players"):
		if body.has_method("show_info_screen"):
			body.show_info_screen(title_text, description_text, type_text)
	
func get_item_group() -> String:
	return qualorquan
