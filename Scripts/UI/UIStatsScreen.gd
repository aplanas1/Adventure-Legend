extends Control

<<<<<<< Updated upstream

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
=======
onready var node_stat_points = get_node("HBoxContainer/VBoxContainer/Stats/MainStats/StatPoint/Label")
var path_main_stats = "HBoxContainer/VBoxContainer/Stats/MainStats/"
var path_derived_stats = "HBoxContainer/VBoxContainer/Stats/DerivedStats/"

var available_points
var strength_add = 0
var dextery_add = 0
var intelligence_add = 0
var constitution_add = 0
var charisma_add = 0
var luck_add = 0

func _ready():
	LoadStats()
	PlayerStats.connect("damage_changed", self, "LoadStats")
	available_points = PlayerStats.stat_points
	node_stat_points.set_text(str(available_points) + " Points")
	if available_points == 0:
		pass
	else:
		for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.set_disabled(false)
	for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.connect("pressed", self, "IncreaseStat", [button.get_node("../..").get_name()])
	for button in get_tree().get_nodes_in_group("MinButtons"):
			button.connect("pressed", self, "DecreaseStat", [button.get_node("../..").get_name()])

func LoadStats():
	get_node(path_main_stats + "Strength/StatBackground/Stat/Value").set_text(str(PlayerStats.strength))
	get_node(path_main_stats + "Dextery/StatBackground/Stat/Value").set_text(str(PlayerStats.dextery))
	get_node(path_main_stats + "Intelligence/StatBackground/Stat/Value").set_text(str(PlayerStats.intelligence))
	get_node(path_main_stats + "Constitution/StatBackground/Stat/Value").set_text(str(PlayerStats.constitution))
	get_node(path_main_stats + "Charisma/StatBackground/Stat/Value").set_text(str(PlayerStats.charisma))
	get_node(path_main_stats + "Luck/StatBackground/Stat/Value").set_text(str(PlayerStats.luck))
	get_node(path_derived_stats + "VBoxContainer/Label").set_text("Damage " + str(PlayerStats.damage))

func IncreaseStat(stat):
	set(stat.to_lower() + "_add", get(stat.to_lower() + "_add") + 1)
	get_node(path_main_stats + stat + "/StatBackground/Stat/Change").set_text(
		"+" + str(get(stat.to_lower() + "_add")) + " ")
	get_node(path_main_stats + stat + "/StatBackground/Min").set_disabled(false)
	available_points -= 1
	node_stat_points.set_text(str(available_points) + " Points")
	if available_points == 0:
		for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.set_disabled(true)

func DecreaseStat(stat):
	set(stat.to_lower() + "_add", get(stat.to_lower() + "_add") - 1)
	if get(stat.to_lower() + "_add") == 0:
		get_node(path_main_stats + stat + "/StatBackground/Min").set_disabled(true)
		get_node(path_main_stats + stat + "/StatBackground/Stat/Change").set_text(" ")
	else:
		get_node(path_main_stats + stat + "/StatBackground/Stat/Change").set_text(
			"+" + str(get(stat.to_lower() + "_add")) + " ")
	available_points += 1
	node_stat_points.set_text(str(available_points) + " Points")
	for button in get_tree().get_nodes_in_group("PlusButtons"):
		button.set_disabled(false)


func _on_Confirm_pressed():
	pass
	if strength_add + dextery_add + intelligence_add + constitution_add + charisma_add + luck_add == 0:
		print("Nothing to confirm")
	else:
		PlayerStats.stat_points = available_points
		PlayerStats.strength += strength_add
		PlayerStats.dextery += dextery_add
		PlayerStats.intelligence += intelligence_add
		PlayerStats.constitution += constitution_add
		PlayerStats.charisma += charisma_add
		PlayerStats.luck += luck_add
		strength_add = 0
		dextery_add = 0
		intelligence_add = 0
		constitution_add = 0
		charisma_add = 0
		luck_add = 0
		LoadStats()
		for button in get_tree().get_nodes_in_group("MinButtons"):
			button.set_disabled(true)
		for label in get_tree().get_nodes_in_group("ChangeLabels"):
			label.set_text("")
>>>>>>> Stashed changes
