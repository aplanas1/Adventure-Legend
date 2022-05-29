extends Node2D

func _ready():
	get_node("Menu/Play").connect("pressed", self, "play")
	get_node("Menu/Exit").connect("pressed", self, "exit")

func play():
	get_tree().change_scene("res://Scenes/World.tscn")
	PlayerStats.health = PlayerStats.max_health

func exit():
	get_tree().quit()

