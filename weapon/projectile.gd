extends Area2D

@export var speed: float = 100
@export var damage: int = 25
@export var enemy_type : String
@export var knockback_decay = 500
@export var strenght_amount = 200
var direction: Vector2 = Vector2.ZERO

func _process(delta):
	position += direction * speed * delta
#
func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("character"):
		if body.get_meta("character") == enemy_type:
			if body.has_method("take_damage"):
				body.take_damage(damage, self.global_position, knockback_decay, strenght_amount)
#
			queue_free()
			
	if body.is_in_group("walls"):
		queue_free()
