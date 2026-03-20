extends TextureRect

@export var artifact_index : int = 0
@export var type : String
@export var artifact : CompressedTexture2D
var pillarnum : String
func _ready() -> void:
	texture = artifact

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if texture != null:
			if GlobalScript.current_pedestal != null:
				GlobalScript.current_pedestal.get_node("artifact_text").texture = load(texture.resource_path)
				GlobalScript.player_artifact_path.erase(texture.resource_path)
				texture = null
