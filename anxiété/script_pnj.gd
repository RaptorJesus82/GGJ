extends CharacterBody2D

var speed = 300

func _physics_process(delta):
	var input_dir = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1

	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1

	if Input.is_action_pressed("ui_up"):
		input_dir.y -= 1

	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1

	velocity = input_dir.normalized() * speed
	move_and_collide(velocity * delta)

@onready var raycast = $RayCast2D
@export var goal : Node2D

func ray_cast():
	if goal == null:
		return false
	raycast.target_position = raycast.to_local(goal.global_position)
	raycast.force_raycast_update()
	if raycast.is_colliding():
		return raycast.get_collider() == goal
	
	return false

func _process(delta):
	if ray_cast():
		print("Player visible!")
	else:
		print("Player hidden!")
