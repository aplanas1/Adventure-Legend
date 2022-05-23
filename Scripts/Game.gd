extends Node2D

onready var _ui_inventory_screen := $CanvasLayer/UI/UIInventoryScreen
onready var _ui_audio_player := $CanvasLayer/UI/AudioStreamPlayer

export(AudioStream) var audio_stream_open_inventory
export(AudioStream) var audio_stream_close_inventory

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		if GameState.state == Types.GameStates.Inventory:
			_ui_inventory_screen.set_visible(false)
			GameState.state = Types.GameStates.Active
			_play_ui_audio(audio_stream_close_inventory)
		else:
			show_inventory()


func show_inventory() -> void:	
	_ui_inventory_screen.set_visible(true)
	GameState.state = Types.GameStates.Inventory
	_play_ui_audio(audio_stream_open_inventory)


func _play_ui_audio(stream : AudioStream) -> void:
	if not stream: return
	_ui_audio_player.set_stream(stream)
	_ui_audio_player.play(0.0)
