extends Control

@onready var char_frame: TextureRect = $char_frame
@onready var name_label = $name_frame/Label
@onready var des_label = $des_frame/Label
@onready var character_display


@onready var character_select = 0
@onready var characters = {
	"jm" : {"path" : "res://character/player_spriite/jm.tscn",
			"name" : "Castro",
			"des" : "He is the legendary programmer!",},
	"faith" : {
		"path" : "res://character/player_spriite/faith.tscn",
		"name" : "Faith",
		"des" : "Born to be a baby girl force to be an independent woman!",
	},
	"ely" : {
		"path" : "res://character/player_spriite/ely.tscn",
		"name" : "Ely",
		"des" : "She is such a cutie!",
	},
	"tine" : {
		"path" : "res://character/player_spriite/tine.tscn",
		"name" : "Tine",
		"des" : "A pretty and strong-wiled woman!",
	},
	"clark" : {
		"path" : "res://character/player_spriite/clark.tscn",
		"name" : "Clark",
		"des" : "He wants to protect people around him!"
	},
	"rose" : {
		"path" : "res://character/player_spriite/rose.tscn",
		"name" : "Rose",
		"des" : "Her charisma was undeafetable!",
	},
}
func  _ready() -> void:
	change_character()

func go_to_world():
	get_tree().change_scene_to_file("res://stages/main_area.tscn")

func _on_go_right_pressed() -> void:
	character_select += 1
	if character_select > 5:
		character_select = 0
	change_character()


func _on_go_left_pressed() -> void:
	character_select -= 1
	if character_select < -1:
		character_select = 5
	change_character()
	
func change_character():
	if char_frame.get_children().size() != 0:
		for child in char_frame.get_children():
			child.queue_free()
				
		get_character()
	else:
		print("no")
		get_character()
		
func get_character():
	#change name
	name_label.text = characters[characters.keys()[character_select]]["name"]
	des_label.text = characters[characters.keys()[character_select]]["des"]
	
	var character_scene = load(characters[characters.keys()[character_select]]["path"])
	character_display = character_scene.instantiate()
	character_display.scale = Vector2(1,1)
	character_display.position = Vector2(17.875,27.125)
	char_frame.add_child(character_display)
	character_display.play("walking_down")


func _on_play_pressed() -> void:
	GlobalScript.weapon_number = character_select
	go_to_world()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://stages/MainMenu.tscn")
