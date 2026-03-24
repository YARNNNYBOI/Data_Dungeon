extends TextureRect
signal artifact_removed
@export var art_name : String
@export var art_type : String
@export var ped_type : String

func check_artifacts():
	var all_true = true

	for key in GlobalScript.pedestal_type.keys():
		# pedestal_type[key][1] is the bool
		if GlobalScript.pedestal_type[key][1] != true:
			all_true = false
			break  # no need to keep checking

	if all_true:
		print("All are true! Do something")
		var main_menu = get_tree().current_scene
		if main_menu.has_method("remove_final_barrier"):
			main_menu.remove_final_barrier()
	else:
		print("Not all are true, do nothing")
		var main_menu = get_tree().current_scene
		if main_menu.has_method("remove_final_barrier"):
			main_menu.remove_final_barrier()
		
func updated_texture():
	if art_type == GlobalScript.pedestal_type[GlobalScript.current_pedestal][0]:
		print("helo")
		GlobalScript.pedestal_type[GlobalScript.current_pedestal][1] = true
		print(GlobalScript.pedestal_type[GlobalScript.current_pedestal][1])
		check_artifacts()

	else:
		GlobalScript.pedestal_type[GlobalScript.current_pedestal][1] = false
		
func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if texture != null and texture.resource_path != "":
			GlobalScript.player_artifacts[art_name] = {
				"path": texture.resource_path,
				"type": art_type
			}
			GlobalScript.pedestals[GlobalScript.current_pedestal] = {
				"path": null,
				"name": "",
				"type": "",
			}
			print(GlobalScript.player_artifacts)
			self.texture = null
			updated_texture()
		else:
			print("No texture to store")
		get_parent().get_parent().get_parent().update_inventory_grid()
