extends StaticBody2D

@export var accepted_group : String
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label

@onready var canaccessinventory = false
@onready var player
var item_on_pedestal : Node2D = null

func _ready() -> void:
	label.visible = false
	
func get_accepted_group() -> String:
	return accepted_group
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and canaccessinventory:
		player.toggle_inventory()
		
func on_correct_item_placed():
	sprite.modulate = Color(0,1,0)  # pedestal glows green
	print("Correct item!")

func on_incorrect_item(area):
	sprite.modulate = Color(1,0,0)  # pedestal glows red
	print("Wrong item!")

func _on_area_2d_area_entered(area: Area2D) -> void:
	label.visible = true

	if area.has_method("get_item_group") and item_on_pedestal == null:
		var group = area.get_item_group()
		var item_name = ""
		
		# Try to get the artifact's item_name from the area
		if area.has_meta("item_name"):
			item_name = area.get_meta("item_name")
		
		# Check if player actually collected it
		var collected_index = GlobalScript.player_artifacts.find(item_name)
		
		if collected_index != -1:
			var collected_group = GlobalScript.player_artifacts_group[collected_index]
			
			if collected_group == accepted_group:
				item_on_pedestal = area
				area.position = global_position  # snap to pedestal
				area.set_process(false)  # freeze movement
				on_correct_item_placed()
			else:
				on_incorrect_item(area)
		else:
			# Player doesn't have it yet
			on_incorrect_item(area)
			
func _on_area_2d_area_exited(area: Area2D) -> void:
	label.visible = false
	if area == item_on_pedestal:
		item_on_pedestal = null
		area.set_process(true)  # re-enable movement
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players") and body.has_method("toggle_inventory"):
		canaccessinventory = true
		player = body
		GlobalScript.isOnPillar = true
		GlobalScript.current_pedestal = self  # track current pedestal

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players") and body.has_method("toggle_inventory"):
		canaccessinventory = false
		player = null
		GlobalScript.isOnPillar = false
		GlobalScript.current_pedestal = null
