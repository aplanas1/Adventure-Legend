extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invencible

onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invencible(value):
	invincible = value
	if invincible == true:
		print("comienza invi")
		emit_signal("invincibility_started")
	else:
		print("termina invi")
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	print("comienza timer")
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_Timer_timeout():
	print("acaba timer")
	self.invincible = false

func _on_Hurtbox_invincibility_started():
	print("invencible")
	set_deferred("monitoring", false)

func _on_Hurtbox_invincibility_ended():
	print("matable")
	monitoring = true
