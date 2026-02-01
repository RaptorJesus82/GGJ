extends RigidBody2D
class_name ennemy_with_sight
@export var SPEED = 300.0
var trajet : PathFollow2D
var direction

@onready var raycast = $"../Tete/RayCast2D"
@export var distance_max_vue = 200000
const TORQUE_FORCE = 700000.0
const MAX_SPEED = 400.0
const FORCE = 12000.0
var mutations = Array()
var player
func _ready():
	player = $"../../player"
	player.muted_up.connect(_on_muting_cat_muted_up)
	player.muted_down.connect(_on_muting_cat_muted_down)
	
func _on_muting_cat_muted_up(mutation : Node2D):
	mutations.append(mutation)
func _on_muting_cat_muted_down(mutation : Node2D):
	mutations.erase(mutation)
func ray_cast():
	for mutation in mutations:
		raycast.target_position = raycast.to_local(mutation.global_position)
		raycast.force_raycast_update()
		if (mutation.global_position - self.position).dot(mutation.global_position - self.position) > distance_max_vue:
			return false
		if (mutation.global_position - self.position).normalized().dot(direction.normalized()) < 0.75:
			return false
		elif raycast.is_colliding():
			return raycast.get_collider() == mutation
	
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
