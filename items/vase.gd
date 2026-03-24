extends Node2D

@onready var on_item
@export var item : PackedScene
@onready var health = 10
func _ready() -> void:
	set_meta("character", "enemy")
	var potion = randi_range(0,GlobalScript.potions.size() - 1)
	on_item = item.instantiate()
	on_item.health_gain = GlobalScript.potion_effects[potion][0]
	on_item.speed_gain = GlobalScript.potion_effects[potion][1]
	on_item.get_node("Sprite2D").texture = load(GlobalScript.potionstext[potion])
	on_item.position = Vector2(global_position.x, global_position.y + 20)
		
func take_damage(amount, source_position, knockback_decay, strenght_amount):
	health -= amount
	print(self.name, health)
	get_tree().current_scene.add_child(on_item)
	queue_free()
