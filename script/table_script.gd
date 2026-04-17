extends Node



func changeTableToFull():
	var table = get_node("res://GUI/inventory/artifact_table.tscn")
	table.texture = load("res://items/table/tablewitems.png")
	
func changeTableToEmpty():
	var table = get_node("res://GUI/inventory/artifact_table.tscn")
	table.texture = load("res://items/table/table.png")
