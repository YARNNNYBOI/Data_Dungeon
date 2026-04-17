extends Control

@onready var temp_player_inventory = {}
@onready var player_inventory: TextureRect = $player_inventory
@onready var table_inventory: TextureRect = $table_inventory

# key : name { path : ##, type: ## }
@onready var table1 = {}
@onready var table2 = {}


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	#checkIfAnyItem()
	pass
	
func ifInventoryIsClosed():
	#print("tempt" + str(temp_player_inventory))
	pass
	
# use the fully change player inventory
func ifInventoryIsOpened():
	#print("player inventory", GlobalScript.player_artifacts)
	clearPlayerSlots()
	clearTableSlots()
	
	
func findKey():
	temp_player_inventory = GlobalScript.player_artifacts
	#print("tmpe player inventory", temp_player_inventory)
	for key in GlobalScript.player_artifacts.keys():
		if key == null:
			print("nothing")
		else:
			placeArtifactOnPlayerSlot(key)
	


	
func placeArtifactOnPlayerSlot(key):
	var index = GlobalScript.player_artifacts.keys().find(key) + 1
	#print(index)
	var current_slot = player_inventory.get_node("pi_" + str(index))
	
	if current_slot:
		current_slot.texture = GlobalScript.player_artifacts[key]["path"]
		current_slot.type = GlobalScript.player_artifacts[key]["type"]
		current_slot.artifact_name = key
		print(current_slot.artifact_name)
	else:
		print("no current slot")
		
		
func clearPlayerSlots():
	for i in range(1,21):
		var current_slot = player_inventory.get_node("pi_" + str(i))
		current_slot.texture = null
	findKey()
#----------------Table Script--------------------#

func findWhichTable():

	if GlobalScript.isTableOneSelected:
		print("table 1 is selected")
		for key in table1:
			if key == null:
				print("nothing")
			else:
				placeArtifactOntableSlot(table1, key)
	else:
		print("table 2 is selected")
		for key in table2:
			if key == null:
				print("nothing")
			else:
				placeArtifactOntableSlot(table2, key)


func placeArtifactOntableSlot(table, key):
	var index = table.keys().find(key) + 1
	var current_slot = table_inventory.get_node("tb_" + str(index))
	print(table)
	if current_slot:
		current_slot.texture = table[key]["path"]
		current_slot.artifact_name = key
		current_slot.type = table[key]["type"]
		print(current_slot.artifact_name)
	else:
		print("no current slot")
		
		
func clearTableSlots():
	for i in range(1,11):
		var current_slot = table_inventory.get_node("tb_" + str(i))
		current_slot.texture = null
	clearColorIndicator()
	findWhichTable()

#func checkIfAnyItem():
	#var isAnyItems = false
	#for i in range(1,11):
		#var current_slot = get_node("tb_" + str(i))
		#if current_slot and current_slot.artifact_name != null:
			#isAnyItems = true
			#break
	#if isAnyItems:
		#TableScript.changeTableToFull()
	#else:
		#TableScript.changeTableToEmpty()
		
#----------------------------Button----------------------#

func clearColorIndicator():
	for item_number in range(1,11):
		var current_slot = table_inventory.get_node("tb_" + str(item_number))
		current_slot.modulate = Color(1,1,1,1)
		
func _on_button_pressed() -> void:
	print("pressed")
	for item_number in range(1,11):
		print(item_number)
		var current_slot = table_inventory.get_node("tb_" + str(item_number))
		if current_slot and current_slot.type != null:
			print(current_slot.type)
			print(current_slot)
			if current_slot.type == "" or current_slot.type == null:
				print("none of the above")
				continue
			elif current_slot.type == GlobalScript.tableType:
				current_slot.modulate = Color(0,255,0)
				print(GlobalScript.tableType, "green")
				continue
			elif current_slot.type != GlobalScript.tableType:
				current_slot.modulate = Color(255,0,0)
				print(GlobalScript.tableType,  "red")
				continue
		else:
			print("no type")
