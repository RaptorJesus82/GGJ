extends RigidBody2D
#class_name ennemy_with_sight
var SPEED
var trajet : PathFollow2D
var direction
var i : int

var distance_max_vue
var TORQUE_FORCE = 700000.0
var MAX_SPEED = 300.0
var FORCE = 30000.0
var mutations = Array()
var raycasts = Array()
var player
var angle_dir

func _ready():
	player = $"../../player"
	player.muted_up.connect(_on_muting_cat_muted_up)
	player.muted_down.connect(_on_muting_cat_muted_down)
	linear_damp = 6.0
	angular_damp = 6.0
	
func _on_muting_cat_muted_up(mutation : Node2D):
	mutations.append(mutation)
	raycasts.append(RayCast2D.new())
	raycasts[-1].set_collision_mask(2)
	$"../Tete/Laser".add_child(raycasts[-1])
	
func _on_muting_cat_muted_down(mutation : Node2D):
	i=mutations.find(mutation)
	mutations.pop_at(i)
	raycasts[i].queue_free()
	raycasts.pop_at(i)
	
func ray_cast(raycast,goal):
	var origin = raycast.global_transform.origin
	var collision_point = raycast.get_collision_point()
	var distance = origin.distance_to(collision_point)
	direction = Vector2(cos(self.global_rotation),sin(self.global_rotation))
	raycast.target_position = raycast.to_local(goal.global_position)
	raycast.force_raycast_update()
	if distance > distance_max_vue:
		return false
	if (collision_point - origin).normalized().dot(direction.normalized()) < 0.75:
		return false
	elif raycast.is_colliding():
		return raycast.get_collider() == goal
	return false
	
func _physics_process(delta: float) -> void:
	trajet.progress += SPEED*delta
	var target_pos = trajet.global_position
	if (target_pos - global_position).dot(target_pos - global_position)>100000:
		direction = (target_pos - global_position).normalized()

		# --- Rotation vers la cible ---
		var desired_angle = direction.angle()
		var angle_diff = wrapf(desired_angle - rotation, -PI, PI)
		if angle_diff>0:
			apply_torque(TORQUE_FORCE)
		else:
			apply_torque(-TORQUE_FORCE)
			
	
		# --- Avancer si on est à peu près orienté ---
		if abs(angle_diff) < 0.5:
			var forward = Vector2.RIGHT.rotated(rotation)
			if linear_velocity.length() < MAX_SPEED:
				apply_central_force(forward * FORCE)
	
	for i in range(len(mutations)):
		if ray_cast(raycasts[i],mutations[i]):
			mutations[i].seen()
