extends Node

var loader
var wait_frames
var time_max = 100
var current_scene

const MAX_LEVEL = 15

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	$Margin/Label.set_text("Loading...")
	
	$Margin.set_modulate(Color(1,1,1,1))
	
	loader = ResourceLoader.load_interactive(path)
	
	if loader == null:
		show_error()
		return
	set_process(true)
	
	current_scene.queue_free()
	
	$ColorRect.set_visible(true)
	$Margin.set_visible(true)
	#$LoadAnimation.play("Loading")
	
	wait_frames = 1

func _process(delta):
	if loader == null:
		# pode dar merda
		set_process(false)
		return
	
	if wait_frames > 0:
		wait_frames = -1
		return
	
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max:
		var err = loader.poll()
		
		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			#update_progress()
			pass
		else:
			show_error()
			loader = null
			break

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node('/root').add_child(current_scene)
	$Margin.set_visible(false)
	$ColorRect.set_visible(false)

func goto_level(level):
	if(level > MAX_LEVEL):
		goto_levels_menu()
		return
	GameState.current_level = level
	var level_path = "res://Assets/GameManager/GameManager.tscn"
	goto_scene(level_path)

func goto_levels_menu():
	goto_scene("res://Menus/LevelsMenu/LevelsMenu.tscn")

func goto_main_menu():
	goto_scene("res://Assets/Menus/MainMenu/MainMenu.tscn")

func goto_credits():
	goto_scene("res://Assets/Menus/Credits/Credits.tscn")