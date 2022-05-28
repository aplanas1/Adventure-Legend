extends Control

#var hearts = 10 setget set_hearts
#var max_hearts = 10 setget set_max_hearts

var health = 10 setget set_health
var max_health = 10 setget set_max_health

onready var actualHealth = $HBoxContainer/ActualHealth
onready var totalHealth = $HBoxContainer/TotalHealth
onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func set_health(value):
	actualHealth = clamp(value, 0, max_health)
	if actualHealth != null:
		get_node("HBoxContainer/ActualHealth").set_text(str(PlayerStats.health) + "")

func set_max_health(value):
	max_health = max(value,1)
	self.health = min(health, max_health)
	if totalHealth != null:
		get_node("HBoxContainer/TotalHealth").set_text(str(PlayerStats.max_health) + "")

#func set_hearts(value):
#	hearts = clamp(value, 0, max_hearts)
#	if heartUIFull != null:
#		heartUIFull.rect_size.x = hearts * 15
#
#func set_max_hearts(value):
#	max_hearts = max(value,1)
#	self.hearts = min(hearts, max_hearts)
#	if heartUIEmpty != null:
#		heartUIEmpty.rect_size.x = max_hearts * 15

func _ready():
	self.max_health = PlayerStats.max_health
	self.health = PlayerStats.health
	# warning-ignore:return_value_discarded
	PlayerStats.connect("max_health_changed", self, "set_max_health")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_health")
