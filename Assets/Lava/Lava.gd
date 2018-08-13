extends Area2D

var player = preload("res://Assets/Sasuke/Sasuke.gd")

func _on_Lava_body_entered(body):
	if body is player:
		body.got_lava()