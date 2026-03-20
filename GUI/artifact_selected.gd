extends TextureRect
@onready var inventory: Control = $"../../.."

@export var artifact_index : int = 0
@export var type : String
var pillarnum : String

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if texture != null:
			print("Artifact Removed")
			GlobalScript.player_artifact_path.append(texture.resource_path)
			texture = null
			inventory.pedestals[GlobalScript.current_pedestal] = null
			inventory.update_inventory_grid()
			
			var cur_ped = GlobalScript.current_pedestal
			var nodes = get_tree().get_nodes_in_group(str(cur_ped))
			if nodes.size() > 0:
				var node = nodes[0]  # first (and ideally only) node
				print("Found node in group p1:", node.name)
				node.get_node("artifact_text").texture = null
		else:
			print("No Texture on Pedestal")
