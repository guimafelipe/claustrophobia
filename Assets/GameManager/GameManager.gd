extends Node2D

#var level = 5
var player
var pause_menu

func _ready():
	pause_menu = $PauseMenu
	pause_menu.set_as_toplevel(true)
	create_level(GameState.current_level)

var creating_level = false

func create_level(level):
	if creating_level:
		return
	creating_level = true
	GameState.set_max_level_reached(level)
	$LevelCreator.clean()
	yield(get_node("LevelCreator"), "finished")
	$LevelCreator.create_map(level)
	yield(get_node("LevelCreator"), "finished")
	player = $LevelCreator.get_player()
	assert(player != null)
	player.connect("won", self, "player_won")
	player.connect("died", self, "player_died")
	player.let_move()
	creating_level = false

func player_won():
	SceneLoader.goto_level(GameState.current_level + 1)

func player_died():
	print('player morreu')
#	create_level(level)
	SceneLoader.goto_level(GameState.current_level)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if creating_level:
			return
		get_tree().paused = true
		player.get_node("Camera2D/PauseMenu").show()
#		get_node("PauseMenu").show()
	if Input.is_action_just_pressed('restart'):
		SceneLoader.goto_level(GameState.current_level)

