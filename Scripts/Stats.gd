extends Node

var level = 1

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health

export(int) var stat_points = 15
export(int) var strength = 0 setget set_strength
export(int) var dextery = 0
export(int) var intelligence = 0
export(int) var constitution = 0
export(int) var charisma = 0
export(int) var luck = 0

var weaponDamage = 0 setget set_weaponDamage
var damage = strength + weaponDamage

signal no_health
signal damage_changed
signal max_health_changed(value)
signal health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:	
		emit_signal("no_health")

func set_strength(value):
	strength = value
	self.damage = strength + weaponDamage
	emit_signal("damage_changed")

func set_weaponDamage(value):
	weaponDamage = value
	self.damage = strength + weaponDamage
	emit_signal("damage_changed")

func _ready():
	self.health = max_health

func levelUp():
	level += 1
	stat_points += 5
