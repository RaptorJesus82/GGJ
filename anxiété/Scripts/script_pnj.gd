extends CharacterBody2D
class_name ennemy_with_sight
@export var SPEED = 300.0
@export var trajet : PathFollow2D
var direction

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
	trajet.progress += SPEED*delta
	direction = trajet.position - self.position
	velocity = SPEED*direction.normalized()
	move_and_slide()
	if ray_cast():
		print("Player visible!")
	else:
		print("Player hidden!")
