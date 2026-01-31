extends CharacterBody2D


const SPEED = 180
const inertia = 1
const rotationspeed = 0.006

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("ui_right") :
		rotation = lerp_angle(rotation, 0, rotationspeed)
		velocity.y = move_toward(velocity.y, SPEED*sin(rotation), SPEED/inertia)
		velocity.x = move_toward(velocity.x, cos(rotation)*SPEED, SPEED/inertia)
	elif Input.is_action_pressed("ui_left") :

		rotation = lerp_angle(rotation, PI, rotationspeed)

		velocity.y = move_toward(velocity.y, SPEED*sin(rotation), SPEED/inertia)
		velocity.x = move_toward(velocity.x, cos(rotation)*SPEED, SPEED/inertia)
	elif Input.is_action_pressed("ui_up") :
		rotation = lerp_angle(rotation, -PI/2, rotationspeed)
		velocity.y = move_toward(velocity.y, SPEED*sin(rotation), SPEED/inertia)
		velocity.x = move_toward(velocity.x, cos(rotation)*SPEED, SPEED/inertia)
	elif Input.is_action_pressed("ui_down") :
		rotation = lerp_angle(rotation, PI/2+0.001, rotationspeed)
		velocity.y = move_toward(velocity.y, SPEED*sin(rotation), SPEED/inertia)
		velocity.x = move_toward(velocity.x, cos(rotation)*SPEED, SPEED/inertia)
		

	else :
		velocity.x = move_toward(velocity.x, 0, SPEED/inertia)
		velocity.y = move_toward(velocity.x, 0, SPEED/inertia)

	move_and_slide()
