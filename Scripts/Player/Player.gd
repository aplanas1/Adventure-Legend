extends KinematicBody2D

const PlayerHurtSound = preload("res://Scenes/Player/PlayerHurtSound.tscn")
const PlayerDeathEffect = preload("res://Scenes/Player/PlayerDeathEffect.tscn")

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 200
export var FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK,
	DEATH
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer2
onready var animationTree = $AnimationTree2
onready var animationState = animationTree.get("parameters/playback")
onready var sworHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

signal death

func _ready():
	randomize()
	stats.connect("no_health", self, "death")
	animationTree.active = true
	sworHitbox.knockback_vector = roll_vector

func death():
	queue_free()
	var playerDeathEffect = PlayerDeathEffect.instance()
	get_parent().add_child(playerDeathEffect)
	playerDeathEffect.global_position = global_position

func _process(delta):
	if GameState.state == Types.GameStates.Active:
		match state:
			MOVE:
				move_state(delta)
			ROLL:
				roll_state(delta)
			ATTACK:
				attack_state(delta)
			DEATH:
				pass
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		sworHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Sword/blend_position", input_vector)
		animationTree.set("parameters/Spear/blend_position", input_vector)
		animationTree.set("parameters/Dash/blend_position", roll_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
func roll_state(_delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Dash")
	hurtbox.start_invincibility(0.2)  #added invincibilty 0.2 sec into roll_state
	move()
	
func attack_state(_delta):
	velocity = Vector2.ZERO
	if (PlayerStats.weapon_type == Types.ItemCategoryTypes.OneHandedWeapons):
		animationState.travel("Sword")
	else:
		animationState.travel("Spear")
	
func move():
	velocity = move_and_slide(velocity)
	
func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE

func attack_animation_finished():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)

func _on_Hurtbox_invincibility_started():
	if state != ROLL:
		blinkAnimationPlayer.play("Start")
func _on_Hurtbox_invincibility_ended():
	if state != ROLL:
		blinkAnimationPlayer.play("Stop")
