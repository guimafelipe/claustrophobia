extends Camera2D

func adjust_zoom(value):
	var current_zoom = zoom.x
	var des_zoom = lerp(current_zoom, value, 0.2)
	set_zoom(Vector2(des_zoom, des_zoom))