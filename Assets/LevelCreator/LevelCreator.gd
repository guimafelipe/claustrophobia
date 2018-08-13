extends Node2D

const SNAP = 64
signal finished

const  player = preload("res://Assets/Sasuke/Sasuke.gd")

var color_to_object = {
	Color(0,0,0) : preload("res://Assets/Wall/Wall.tscn"),
	Color(0,0,1) : preload("res://Assets/Sasuke/Sasuke.tscn"),
	Color(1,1,0) : preload("res://Assets/Mushroom/Mushroom.tscn"),
	Color(1,0,0) : preload("res://Assets/Lava/Lava.tscn"),
	Color(0,1,0) : preload("res://Assets/Goal/Goal.tscn"),
}
func clean():
	for child in get_children():
		child.queue_free()
	yield(get_tree().create_timer(0.5), "timeout")
	emit_signal('finished')
	
func create_map(level):
	var image = Image.new()
	print('criando level ', str(level))
	image.load("res://Assets/LevelImages/level" + str(level) + ".png")
	var H = image.get_height()
	var W = image.get_width()
	image.lock()
	for i in range(W):
		for j in range(H):
			var color = image.get_pixel(i, j)
			if color.a > 0:
				color.a = 1
				create_object(color, i, j)
	yield(get_tree().create_timer(1.0), "timeout")
	emit_signal('finished')

func get_player():
	for child in get_children():
		if child is player:
			return child
	return null

func create_object(color, i, j):
	var obj = color_to_object[color].instance()
	if color == Color(0,0,1):
		print(i, ' ', j)
	obj.translate(Vector2(i*SNAP, j*SNAP))
	add_child(obj)
	