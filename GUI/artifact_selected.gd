extends TextureRect

@export var artifact_index : int = 0
@export var type : String
var pillarnum : String
func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("bing")
		if texture.resource_path != null:
			print("bong")
			GlobalScript.player_artifact_path.append(texture.resource_path)
			texture = null
			
