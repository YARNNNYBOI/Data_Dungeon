extends Control

@onready var temp_player_inventory

func _ready() -> void:
	print(temp_player_inventory)
	
# get the player inventory

# use the fully change player inventory
func ifInventoryIsOpened():
	temp_player_inventory = GlobalScript.player_artifacts
	
	for key in GlobalScript.player_artifacts:
		if key == null:
			print("nothing")
		else:
			print("hello")
	
func ifInventoryIsClosed():
	GlobalScript.player_artifacts = temp_player_inventory
