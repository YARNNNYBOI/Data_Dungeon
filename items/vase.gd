extends Node2D

@onready var on_item
@export var item : PackedScene
@onready var health = 10
func _ready() -> void:
		set_meta("character", "enemy")
		on_item = item.instantiate()
		on_item.health_gain = 10
		on_item.position = Vector2(global_position.x, global_position.y + 20)
		
func take_damage(amount, source_position, knockback_decay, strenght_amount):
	health -= amount
	print("Health:", health)
	get_tree().current_scene.add_child(on_item)
	queue_free()
