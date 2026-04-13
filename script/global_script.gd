extends Node


#ito lng tignan mo faith :DDD
var weapon_number : int = 0

var health = 100
var speed = 100

var character_sprite = ["res://character/player_spriite/jm.tscn","res://character/player_spriite/faith.tscn","res://character/player_spriite/ely.tscn","res://character/player_spriite/tine.tscn","res://character/player_spriite/clark.tscn","res://character/player_spriite/rose.tscn"]

var weapon = ["res://weapon/weapon.tscn", "res://weapon/weapon_range.tscn","res://weapon/weapon_range.tscn", "res://weapon/weapon.tscn","res://weapon/weapon.tscn","res://weapon/weapon.tscn"]
var weaponsprite = ["res://weapon/sprites/swordnijm(32x32).png","res://weapon/sprites/bow.png","res://weapon/sprites/staff(16x16).png","res://weapon/sprites/Scythe.png","res://weapon/sprites/swordnijm(32x32).png","res://weapon/sprites/picax.png"]
var isOnStage1 = false

var weapon_offset_right = [Vector2(16,-16),Vector2(15,-15),Vector2(-4,-15),Vector2(15,-15),Vector2(16,-16),Vector2(15,-15)]
var weapon_offset_left = [Vector2(16,16),Vector2(15,-15),Vector2(4,-6),Vector2(15,15),Vector2(16,16),Vector2(15,15)]
var weapon_scale = [Vector2(7,7),Vector2(6,6),Vector2(10,10),Vector2(7,7),Vector2(7,7),Vector2(5,5)]
var weapon_damage = [400, 35, 50, 50, 30, 25]
var weapon_cooldown = [1, 0.7, 1, 1.5, 0.5, 0.2]
var knockback_decay = [500,300,300,500,350,600]
var strength_amount = [200,150,100,300,150,100]
var projectile_speed = [null,150,300,null,null,null]
var weapon_range = [Vector2(0.5, 100), Vector2(0, 0), Vector2(0, 0), Vector2(0.5, 150), Vector2(0.5, 60), Vector2(0.5, 60)]
var weapon_position_right = [Vector2(28,68),Vector2(-50,35),Vector2(46,26),Vector2(24,59),Vector2(28,68),Vector2(1,72)]
var weapon_position_left = [Vector2(28,-68),Vector2(-28,-350),Vector2(-46,46),Vector2(1,-50),Vector2(28,-68),Vector2(1,-72)]

var projectile = ["res://weapon/sprites/arrow.png","res://weapon/sprites/arrow.png","res://weapon/sprites/projectile_staff.png","res://weapon/sprites/arrow.png","res://weapon/sprites/arrow.png","res://weapon/sprites/arrow.png"]

var weapon_rotation_right = [0,0,0,0,0,0]
var weapon_rotation_left = [0,0,0,0,0,0]

var isOnStage1Enemy = []

var room1enemies : int
var isRoomOnClear = false

var player_artifacts = {
}

var current_pedestal = false
var using_pedestal = false
var on_pedestal = false

var pedestal_type = {
	"p1" : ["quali", false],
	"p2" : ["quali", false],
	"p3" : ["quali", false],
	"p4" : ["quanti", false],
	"p5" : ["quanti", false],
	"p6" : ["quanti", false],
}

#stores the value for the artifacts inside the pedestals
var pedestals = {
}

var can_move = true
var main_menu_pos = Vector2(-64.0,-24.0)

var weapon_swing = false

var potions = ["health", "speed"]
var potion_effects = [[25,0],[0,5]]
var potionstext = ["res://items/potions/health_potion.png", "res://items/potions/speed_potion.png"]

var isOnPillar: bool = false
