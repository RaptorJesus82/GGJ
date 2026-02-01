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
	
func ray_cast():
	for i in range(len(mutations)):
		raycasts[i].target_position = raycasts[i].to_local(mutations[i].global_position)
		direction = Vector2(cos(self.global_rotation),sin(self.global_rotation))
		raycasts[i].force_raycast_update()
		if ((mutations[i].global_position - self.position).dot(mutations[i].global_position - self.position) < distance_max_vue):
			if ((mutations[i].global_position - self.position).normalized().dot(direction.normalized()) > 0.75):
				print("youpi1")
				if (raycasts[i].is_colliding()):
					print("youpi2")
					print(mutations[i].name)
					print(raycasts[i].get_collider()[0])
					if (raycasts[i].get_collider() == mutations[i]):
						mutations[i].seen()

func _process(delta):
	ray_cast()
	
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
