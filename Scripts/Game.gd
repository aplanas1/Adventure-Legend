extends Node2D

onready var _ui_inventory_screen := $CanvasLayer/UI/UIInventoryScreen
onready var _ui_stats_screen := $CanvasLayer/UI/UIStatsScreen
onready var _ui_audio_player := $CanvasLayer/UI/AudioStreamPlayer

export(AudioStream) var audio_stream_open_inventory
export(AudioStream) var audio_stream_close_inventory

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		if GameState.state == Types.GameStates.Inventory:
			_ui_inventory_screen.set_visible(false)
			_ui_stats_screen.set_visible(false)
			GameState.state = Types.GameStates.Active
			_play_ui_audio(audio_stream_close_inventory)
		else:
			show_inventory()
	if event.is_action_pressed("open_stats"):
		if GameState.state == Types.GameStates.Inventory:
			_ui_stats_screen.set_visible(false)
			_ui_inventory_screen.set_visible(false)
			GameState.state = Types.GameStates.Active
			_play_ui_audio(audio_stream_close_inventory)
		else:
<<<<<<< Updated upstream
			show_character()
=======
			show_stats()
>>>>>>> Stashed changes


func show_inventory() -> void:	
	_ui_stats_screen.set_visible(false)
	_ui_inventory_screen.set_visible(true)
	_ui_stats_screen.set_visible(false)
	GameState.state = Types.GameStates.Inventory
	_play_ui_audio(audio_stream_open_inventory)
	
func show_stats() -> void:	
	_ui_stats_screen.set_visible(true)
	_ui_inventory_screen.set_visible(false)
	GameState.state = Types.GameStates.Inventory
	_play_ui_audio(audio_stream_open_inventory)

func show_character() -> void:	
	_ui_inventory_screen.set_visible(false)
	_ui_stats_screen.set_visible(true)
	GameState.state = Types.GameStates.Inventory
	_play_ui_audio(audio_stream_open_inventory)

func _play_ui_audio(stream : AudioStream) -> void:
	if not stream: return
	_ui_audio_player.set_stream(stream)
	_ui_audio_player.play(0.0)
