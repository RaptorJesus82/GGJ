extends CharacterBody2D
class_name ennemy_with_sight
@export var SPEED = 300.0
@export var trajet : PathFollow2D
var direction

@onready var raycast = $RayCast2D
@export var goal : Node2D
@export var distance_max_vue = 200000

func ray_cast():
	if goal == null:
		return false
	raycast.target_position = raycast.to_local(goal.global_position)
	raycast.force_raycast_update()
	#print((goal.global_position - self.position).normalized())
	#print(direction.normalized())
	if (goal.global_position - self.position).dot(goal.global_position - self.position) > distance_max_vue:
		#print("trop loin")
		return false
	if (goal.global_position - self.position).normalized().dot(direction.normalized()) < 0.75:
		#print("angle trop grand")
		return false
	elif raycast.is_colliding():
		return raycast.get_collider() == goal
	
	return false

func _process(delta):
	if ray_cast():
		print("Player visible!")
	else:
		print("Player hidden!")
		
func _physics_process(delta: float) -> void:
	trajet.progress += SPEED*delta
	direction = trajet.position - self.position
	velocity = SPEED*direction.normalized()
	look_at(trajet.position)
	move_and_slide()
