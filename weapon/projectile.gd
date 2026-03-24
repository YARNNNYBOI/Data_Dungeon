extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 100
@export var damage: int = 25
@export var enemy_type : String
@export var knockback_decay = 500
@export var strenght_amount = 200


var direction: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO
var reached_target := false

func _ready() -> void:
	animated_sprite_2d.look_at(target_position)
	
func setup(start_pos: Vector2, target: Vector2):
	global_position = start_pos
	target_position = target
	direction = (target - start_pos).normalized()
	
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
