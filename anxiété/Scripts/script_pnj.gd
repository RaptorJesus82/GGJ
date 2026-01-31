extends RigidBody2D
class_name ennemy_with_sight
@export var SPEED = 300.0
var trajet : PathFollow2D
var direction

@onready var raycast = $RayCast2D
@export var goal : Node2D
@export var distance_max_vue = 200000
const TORQUE_FORCE = 700000.0
const MAX_SPEED = 400.0
const FORCE = 12000.0

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
	var target_pos = trajet.global_position
	direction = (target_pos - global_position).normalized()

	# --- Rotation vers la cible ---
	var desired_angle = direction.angle()
	var angle_diff = wrapf(desired_angle - rotation, -PI, PI)
	apply_torque(angle_diff * TORQUE_FORCE)

	# --- Avancer si on est à peu près orienté ---
	if abs(angle_diff) < 0.5:
		var forward = Vector2.RIGHT.rotated(rotation)
		if linear_velocity.length() < MAX_SPEED:
			apply_central_force(forward * FORCE)
