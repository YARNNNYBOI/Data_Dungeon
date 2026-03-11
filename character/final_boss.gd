extends CharacterBody2D

@onready var boss_sprite: Sprite2D = $boss_sprite
@onready var color_timer: Timer = $color_timer

@export var health = 300



func take_damage(amount, source_position):
	health -= amount
	damage_effect()
	print("Health:", health)
	check_status()
	
func damage_effect():
	boss_sprite.modulate = Color(1, 0, 0)  # red
	color_timer.start()

func check_status():
	if health <= 0:
		GlobalScript.room1enemies += 1
		queue_free()

func _on_color_timer_timeout() -> void:
	boss_sprite.modulate = Color(1, 1, 1, 1)
