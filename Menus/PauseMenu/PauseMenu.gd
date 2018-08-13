extends Control

func _ready():
	pass


func _on_MenuBtn_button_up():
	get_tree().paused = false
	SceneLoader.goto_levels_menu()


func _on_ResumeBtn_button_up():
	hide()
	get_tree().paused = false