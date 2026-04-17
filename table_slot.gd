extends TextureRect

@export var artifact_name: String
@export var type: String

func playerInventory():
	var parent = get_parent().get_parent()
	if self.artifact_name:
		parent.temp_player_inventory[self.artifact_name] = {
			"path": self.texture,
			"type": self.type,
			}
		removeArtifact()

func removeArtifact():
	var parent = get_parent().get_parent()
	if GlobalScript.isTableOneSelected:
		if parent.table1.has(artifact_name):
			parent.table1.erase(artifact_name)
			print("new list ", parent.table1)
	else:
		if parent.table2.has(artifact_name):
			parent.table2.erase(artifact_name)
			print("new list ", parent.table2)
			
	self.artifact_name = ""
	self.texture = null
	self.type = ""
	parent.clearPlayerSlots()

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		playerInventory()
