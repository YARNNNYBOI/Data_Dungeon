extends Control

@onready var artifact_grid: GridContainer = $Inventory/GridContainer
@onready var inventory: TextureRect = $Inventory
@onready var texture_rect: TextureRect = $Inventory/GridContainer2/TextureRect

@onready var pedestals = {
	"p1" : null,
	"p2" : null,
	"p3" : null,
	"p4" : null,
	"p5" : null,
}

func update_inventory_grid():
	
	var key = str(GlobalScript.current_pedestal)
	# Update pedestal display safely
	if pedestals[GlobalScript.current_pedestal]:
		texture_rect.texture = load(pedestals[key])
	else:
		texture_rect.texture = null
		print("No texture found for pedestal:", key)

	# Clear all slots first
	for cell in artifact_grid.get_children():
		if cell is TextureRect:
			cell.texture = null

	# Fill cells directly using paths (NO splitting nonsense)
	for i in range(GlobalScript.player_artifact_path.size()):
		if i >= artifact_grid.get_child_count():
			break

		var tex_path = GlobalScript.player_artifact_path[i]
		var tex = load(tex_path)

		var cell = artifact_grid.get_child(i)
		if cell is TextureRect:
			cell.texture = tex
