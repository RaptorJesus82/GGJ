extends RigidBody2D

const FORCE = 30000.0
const TORQUE_FORCE = 700000.0
const MAX_SPEED = 400.0

func _ready():
	linear_damp = 6.0
	angular_damp = 6.0

func _physics_process(delta):

	if Input.is_action_pressed("ui_left"):
		apply_torque(-TORQUE_FORCE)

	if Input.is_action_pressed("ui_right"):
		apply_torque(TORQUE_FORCE)

	# --- Avancer ---
	if Input.is_action_pressed("ui_up"):
		var forward = Vector2.RIGHT.rotated(rotation)
		if linear_velocity.length() < MAX_SPEED:
			apply_central_force(forward * FORCE)
			
	if Input.is_action_pressed("ui_down"):
		var backward = Vector2.LEFT.rotated(rotation)
		if linear_velocity.length() < MAX_SPEED:
			apply_central_force(backward * FORCE * 0.4)
