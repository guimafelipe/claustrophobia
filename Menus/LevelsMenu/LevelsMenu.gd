extends Control

var button_class = preload('res://Menus/LevelsMenu/LevelButton.tscn')

func _ready():
	construct_buttons(SceneLoader.MAX_LEVEL)

func button_pressed(level):
	SceneLoader.goto_level(level)

func construct_buttons(num):
	var container = $MarginContainer/GridContainer
	for i in range(num):
		var new_btn = button_class.instance()
		new_btn.LEVEL = i+1
		container.add_child(new_btn)
