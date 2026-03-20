extends TextureRect

@onready var artifact_select: TextureRect = $"../../GridContainer2/TextureRect"
@onready var inventory: Control = $"../../.."

@export var artifact_index : int = 0
@export var type : String
@export var artifact : CompressedTexture2D

var pillarnum : String

func _ready() -> void:
	texture = artifact

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if texture != null and GlobalScript.current_pedestal != "":
			# Get all pedestal nodes
			
			var cur_ped = GlobalScript.current_pedestal
			# Save artifact path in inventory dictionary
			inventory.pedestals[cur_ped] = texture.resource_path

			# Load the texture safely
			var path = inventory.pedestals.get(cur_ped, null)
			if path:
				artifact_select.texture = load(path)
			else:
				artifact_select.texture = null
				
			

			# Remove artifact from player's inventory
			GlobalScript.player_artifact_path.erase(texture.resource_path)
			texture = null


			print(inventory.pedestals)
			var nodes = get_tree().get_nodes_in_group(str(cur_ped))
			if nodes.size() > 0:
				var node = nodes[0]  # first (and ideally only) node
				print("Found node in group p1:", node.name)
				node.get_node("artifact_text").texture = load(inventory.pedestals[GlobalScript.current_pedestal])
