extends KinematicBody2D

var motion = Vector2()

const OG = 9.8
const OJUMPV = -400
const OSPEED = 300
const OXLR8 = 100

var G = OG
var JUMPV = OJUMPV
var SPEED = OSPEED
var XLR8 = OXLR8


const UP = Vector2(0, -1)
const FRICTION = 0.15

signal won
signal died

var can_move = false

func let_move():
	can_move = true

func _physics_process(delta):
	motion.y += G
	
	if can_move and Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + XLR8, SPEED)
	if can_move and Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - XLR8, -SPEED)
	motion.x = lerp(motion.x, 0, FRICTION)
	
	
	if is_on_floor() || foot_counter > 0:
		if can_move and Input.is_action_just_pressed("jump"):
			motion.y = JUMPV
	
	motion = move_and_slide(motion, UP)


var grow_size = 1
var grow_speed = 0.15
var mushroom_dec = 1.5

func _process(delta):
	grow(delta)
	check_colliders()

func grow(delta):
	if not can_move:
		return
	grow_size+=delta*grow_speed
	G=OG*grow_size
	JUMPV=OJUMPV*grow_size
	SPEED=OSPEED*grow_size
	XLR8=OXLR8*grow_size
	set_scale(Vector2(grow_size, 1.5*grow_size))
	$Camera2D.adjust_zoom(grow_size)

func got_lava():
	die()

func die():
	if not can_move:
		return
	can_move = false
	emit_signal('died')

func got_mushroom():
	grow_size = max(1, grow_size - mushroom_dec)

func reached_goal():
	if not can_move:
		return
	emit_signal('won')

var foot_counter = 0
var head_counter = 0
var left_counter = 0
var right_counter = 0

func check_colliders():
	if foot_counter > 0 and head_counter > 0:
		die()

func check_body(body):
	return body is StaticBody2D

func _on_Foot_body_entered(body):
	if check_body(body):
		foot_counter+=1

func _on_Foot_body_exited(body):
	if check_body(body):
		foot_counter-=1


func _on_Head_body_entered(body):
	if check_body(body):
		head_counter+=1


func _on_Head_body_exited(body):
	if check_body(body):
		head_counter-=1


func _on_Left_body_entered(body):
	if check_body(body):
		left_counter+=1

func _on_Left_body_exited(body):
	if check_body(body):
		left_counter-=1

func _on_Right_body_entered(body):
	if check_body(body):
		right_counter+=1

func _on_Right_body_exited(body):
	if check_body(body):
		right_counter-=1