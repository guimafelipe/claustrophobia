extends Node

var max_level_reached = 0
var current_level = 1
const import_path = "res://.import/"
const import_end = ".stex"

var level_images = [

]

func save():
	var mlr = max_level_reached
	var save_game = File.new()
	save_game.open("user://game_data.save", File.WRITE)
	var save_dict = {
		"shake_bananas": mlr ,
	}
	save_game.store_line(to_json(save_dict))

func load_game():
	var save_game = File.new()
	if(not save_game.file_exists("user://game_data.save")):
		return
	save_game.open("user://game_data.save", File.READ)
	var info = parse_json(save_game.get_line())
	max_level_reached = info["shake_bananas"]
	save_game.close()

func set_max_level_reached(value):
	if(max_level_reached > value):
		return
	max_level_reached = value
	save()

func _ready():
	load_game()

