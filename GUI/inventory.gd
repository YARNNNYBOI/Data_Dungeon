extends Control

@onready var artifact_grid: GridContainer = $Inventory/GridContainer
@onready var inventory: TextureRect = $Inventory

func update_inventory_grid():
	# Swap inventory texture depending on pedestal proximity
	if InventoryScript.can_access_inventory:
		inventory.texture = load("res://GUI/Pedestal.png")
	else:
		inventory.texture = load("res://GUI/Inventory.png")

	# Clear all slots first
	for cell in artifact_grid.get_children():
		if cell is TextureRect:
			cell.texture = null

	# Fill cells with artifacts
	for i in range(GlobalScript.player_artifacts.size()):
		var tex
		var artifact_name = GlobalScript.player_artifacts[i]
		var number = artifact_name.split("_")[1].to_int() - 1
		if GlobalScript.player_artifact_path.is_empty():
			tex = null
		else:
			var tex_path = GlobalScript.player_artifact_path[number]
			tex = load(tex_path)


		if i < artifact_grid.get_child_count():
			var cell = artifact_grid.get_child(i)
			cell.texture = tex
