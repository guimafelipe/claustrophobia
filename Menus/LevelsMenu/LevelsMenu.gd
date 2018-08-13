extends Control

func _ready():
	pass

func button_pressed(level):
	SceneLoader.goto_level(level)