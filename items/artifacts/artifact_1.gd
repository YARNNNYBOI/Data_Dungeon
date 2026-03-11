extends Node2D
class_name artifact

@onready var isPlayerinArea = false
@onready var control: Control = $Control

@export var item_name : String
@export var artifact_text : CompressedTexture2D
@export var qualorquan : String
@export var title_text : String
@export var description_text : String

@onready var player
@onready var show_info = false



func _ready() -> void:
	add_to_group(qualorquan)
	set_meta("item_name", item_name)
	isPlayerinArea = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and isPlayerinArea:
		if control.visible:
			GlobalScript.player_artifacts.append(item_name)
			GlobalScript.player_artifacts_group.append(qualorquan)
			print("artifact collected: ", item_name)
			if show_info:
				check_body(player)
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		print("artifact near")
		show_info = true
		player = body
		isPlayerinArea = true
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		print("artifact no more near")
		isPlayerinArea = false

func check_body(body:Node2D):
	print("about tochecki not")
	if body.is_in_group("players"):
		print("checing info")
		if body.has_method("show_info_screen"):
			print("showing info")
			body.show_info_screen(title_text, description_text)
	
func get_item_group() -> String:
	return qualorquan
