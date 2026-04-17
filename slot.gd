extends TextureRect

@export var artifact_name: String
@export var type: String


func whichTableIsSelected():
	print("type", type)
	var parent = get_parent().get_parent()
	if GlobalScript.isTableOneSelected:
		if self.artifact_name:
			parent.table1[self.artifact_name] = {
				"path": self.texture,
				"type": self.type,
				}
			removeArtifact()
			print("table 1 inputed")
	else:
		if self.artifact_name:
			parent.table2[self.artifact_name] = {
				"path": self.texture,
				"type": self.type,
				}
			removeArtifact()
			print("table 2 inputed")

func removeArtifact():
	var parent = get_parent().get_parent()
	if parent.temp_player_inventory.has(artifact_name):
		parent.temp_player_inventory.erase(artifact_name)
		print("new list ", parent.temp_player_inventory)
	self.artifact_name = ""
	self.texture = null
	self.type = ""
	parent.clearTableSlots()
	#TableScript.changeTableToFull()

func _gui_input(event):
	var parent = get_parent().get_parent()
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		whichTableIsSelected()
