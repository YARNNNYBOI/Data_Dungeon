extends TextureRect
@onready var artifact_select: TextureRect = $"../../GridContainer2/TextureRect"
@onready var inventory: Control = $"../../.."


@export var art_type : String
@export var art_name : String


var pillarnum : String

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if texture != null:
			if GlobalScript.on_pedestal == true:
				print("true")
				artifact_select.texture = load(texture.resource_path)
				artifact_select.art_name = art_name
				artifact_select.art_type = art_type
				artifact_select.updated_texture()
				GlobalScript.pedestals[GlobalScript.current_pedestal] = {
					"path" : texture.resource_path,
					"name" : art_name,
					"type" : art_type,
				}
				print(GlobalScript.pedestals[GlobalScript.current_pedestal])
				GlobalScript.player_artifacts.erase(art_name)
				get_parent().get_parent().get_parent().update_inventory_grid()
				texture = null
				
