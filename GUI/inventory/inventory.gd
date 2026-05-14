extends Control

@onready var temp_player_inventory = {}
@onready var player_inventory: TextureRect = $player_inventory
@onready var table_inventory: TextureRect = $table_inventory
@onready var label: Label = $artifact_name/Label
@onready var label2: Label = $type_display/Label

# key : name { path : ##, type: ## }
@onready var table1 = {}
@onready var table2 = {}


@onready var p = [$player_inventory/pi_1, 
				$player_inventory/pi_2, 
				$player_inventory/pi_3, 
				$player_inventory/pi_4, 
				$player_inventory/pi_5, 
				$player_inventory/pi_6, 
				$player_inventory/pi_7, 
				$player_inventory/pi_8, 
				$player_inventory/pi_9, 
				$player_inventory/pi_10, 
				$player_inventory/pi_11, 
				$player_inventory/pi_12, 
				$player_inventory/pi_13, 
				$player_inventory/pi_14, 
				$player_inventory/pi_15, 
				$player_inventory/pi_16, 
				$player_inventory/pi_17, 
				$player_inventory/pi_18, 
				$player_inventory/pi_19, 
				$player_inventory/pi_20]


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
		label2.text = "Qualitative"
		for key in table1:
			if key == null:
				print("nothing")
			else:
				placeArtifactOntableSlot(table1, key)
	else:
		print("table 2 is selected")
		label2.text = "Quantitative"
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


func get_artifact_name(number):
	if p[int(number)].artifact_name != "":
		label.text = p[int(number)].artifact_name
	else:
		label.text = ""

func _on_pi_1_mouse_entered() -> void:
	get_artifact_name(0)


func _on_pi_2_mouse_entered() -> void:
	get_artifact_name(1)


func _on_pi_3_mouse_entered() -> void:
	get_artifact_name(2)


func _on_pi_4_mouse_entered() -> void:
	get_artifact_name(3)


func _on_pi_5_mouse_entered() -> void:
	get_artifact_name(4)


func _on_pi_6_mouse_entered() -> void:
	get_artifact_name(5)


func _on_pi_7_mouse_entered() -> void:
	get_artifact_name(6)


func _on_pi_8_mouse_entered() -> void:
	get_artifact_name(7)


func _on_pi_9_mouse_entered() -> void:
	get_artifact_name(8)


func _on_pi_10_mouse_entered() -> void:
	get_artifact_name(9)


func _on_pi_11_mouse_entered() -> void:
	get_artifact_name(10)

func _on_pi_12_mouse_entered() -> void:
	get_artifact_name(11)


func _on_pi_13_mouse_entered() -> void:
	get_artifact_name(12)


func _on_pi_14_mouse_entered() -> void:
	get_artifact_name(13)


func _on_pi_15_mouse_entered() -> void:
	get_artifact_name(14)


func _on_pi_16_mouse_entered() -> void:
	get_artifact_name(15)


func _on_pi_17_mouse_entered() -> void:
	get_artifact_name(16)


func _on_pi_18_mouse_entered() -> void:
	get_artifact_name(17)


func _on_pi_19_mouse_entered() -> void:
	get_artifact_name(18)


func _on_pi_20_mouse_entered() -> void:
	get_artifact_name(19)
