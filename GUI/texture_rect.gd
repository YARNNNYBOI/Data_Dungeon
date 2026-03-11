extends TextureRect

# The index in the player_artifacts array this cell represents
@export var artifact_index : int = 0

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Only proceed if player is near a pedestal
		if GlobalScript.isOnPillar:
			check_artifact_with_pedestal()

func check_artifact_with_pedestal():
	# Make sure the index exists
	if artifact_index >= GlobalScript.player_artifacts.size():
		return

	var artifact_group = GlobalScript.player_artifacts_group[artifact_index]
	var artifact_name = GlobalScript.player_artifacts[artifact_index]

	# Loop through all pedestals nearby or just use the one flagged in GlobalScript
	if GlobalScript.current_pedestal:
		var pedestal = GlobalScript.current_pedestal
		if artifact_group == pedestal.accepted_group:
			pedestal.on_correct_item_placed()
			print("Placed:", artifact_name, "Correct group:", artifact_group)
		else:
			pedestal.on_incorrect_item(self)
			print("Placed:", artifact_name, "Wrong group:", artifact_group)
