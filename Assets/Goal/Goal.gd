extends Area2D

const player = preload("res://Assets/Sasuke/Sasuke.gd")

func _on_Goal_body_entered(body):
	if body is player:
		body.reached_goal()