extends Control
@onready var artifact_select: TextureRect = $Inventory/GridContainer2/TextureRect
@onready var artifact_grid: GridContainer = $Inventory/GridContainer
@onready var inventory: TextureRect = $Inventory


func update_inventory_grid():
	var pedestal = GlobalScript.pedestals.get(GlobalScript.current_pedestal)
	artifact_select.texture = null # reset first

	if pedestal and pedestal.has("path"):
		var path_or_texture = pedestal["path"]

		# Only load if it's a string
		if typeof(path_or_texture) == TYPE_STRING and path_or_texture != "":
			artifact_select.texture = load(path_or_texture)


# Clear all slots first
	for cell in artifact_grid.get_children():
		if cell is TextureRect:
			cell.texture = null

	# Fill cells with artifacts
	#print("size: ", GlobalScript.player_artifacts.size())
	for i in range(GlobalScript.player_artifacts.size()):
		var artifact_name = GlobalScript.player_artifacts.keys()[i]
		#print("artifact ", artifact_name)
		var tex = null

		if GlobalScript.player_artifacts[artifact_name]["path"] != null :
			var path = GlobalScript.player_artifacts[artifact_name]["path"]
			#print(path)
			if path != null:
				tex = path
				#print(tex)

		if i < artifact_grid.get_child_count():
			var cell = artifact_grid.get_child(i)
			if cell is TextureRect:
				if typeof(tex) == TYPE_STRING:
					cell.texture = load(tex)   # load string path into Texture
				elif typeof(tex) == TYPE_OBJECT and tex is Texture2D:
					cell.texture = tex         # assign directly if Texture
				else:
					cell.texture = null        # safe fallback

				cell.art_name = artifact_name
				cell.art_type = GlobalScript.player_artifacts[artifact_name]["type"]
