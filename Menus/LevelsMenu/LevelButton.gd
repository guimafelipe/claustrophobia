extends Button

export var LEVEL = 1

signal level_btn_pressed(level)

func _ready():
	set_text(str(LEVEL))
#	set_disabled(GameState.max_level_reached < LEVEL && LEVEL != 1)
	connect("level_btn_pressed", get_node("../../.."), "button_pressed")

func _on_Button_button_up():
	emit_signal("level_btn_pressed", LEVEL)