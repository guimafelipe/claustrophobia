extends Area2D

var player = preload("res://Assets/Sasuke/Sasuke.gd")

func _on_Mushroom_body_entered(body):
	if body is player:
		body.got_mushroom()
		queue_free()