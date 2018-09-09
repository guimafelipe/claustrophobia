extends Control

func _on_MenuBtn_button_up():
	get_tree().paused = false
	SceneLoader.goto_levels_menu()

func _on_ResumeBtn_button_up():
	hide()
	get_tree().paused = false
	justpress = false

var justpress = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if not justpress:
			justpress = true
		else:
			_on_ResumeBtn_button_up()