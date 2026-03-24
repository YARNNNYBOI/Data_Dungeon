extends StaticBody2D

# ==================================================
# NODES
# ==================================================
@onready var label: Label = $Label
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var grid_container: GridContainer = $CanvasLayer/Inventory/GridContainer
@onready var artifact_display: Sprite2D = $Artifact_display

# ==================================================
# STATE
# ==================================================
var player = null
var can_access_inventory: bool = false
var isAlreadyOpen = false

# each pedestal now stores its own artifacts
var player_artifact_path = GlobalScript.player_artifact_path
@export var pillarnum : String

# ==================================================
# READY
# ==================================================
func _ready() -> void:
	label.visible = false
	canvas_layer.visible = false
	update_grid()

# ==================================================
# PROCESS
# ==================================================
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("inventory"):

		if !isAlreadyOpen and InventoryScript.can_access_inventory:
			canvas_layer.visible = true
			isAlreadyOpen = true
			GlobalScript.can_move = false
			update_grid()

		elif isAlreadyOpen and InventoryScript.can_access_inventory:
			canvas_layer.visible = false
			isAlreadyOpen = false
			GlobalScript.can_move = true
			update_grid()


# ==================================================
# PLAYER ENTER / EXIT
# ==================================================
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players") and body.has_method("toggle_inventory"):
		InventoryScript.can_access_inventory = true
		player = body
		GlobalScript.current_pedestal = self
		label.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("players") and body.has_method("toggle_inventory"):
		InventoryScriptcan_access_inventory = false
		player = null
		GlobalScript.current_pedestal = null
		label.visible = false

# ==================================================
# GRID DISPLAY
# ==================================================
func update_grid() -> void:
	print("being called")
	var cells = grid_container.get_children()

	for i in range(cells.size()):
		if cells[i] is TextureRect:
			if i < player_artifact_path.size():
				cells[i].texture = load(player_artifact_path[i])
				cells[i].pillarnum = pillarnum
			else:
				cells[i].texture = null
		else:
			print("not texturerect")
