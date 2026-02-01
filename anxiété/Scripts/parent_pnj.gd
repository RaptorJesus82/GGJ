extends Node2D
@export var path : PathFollow2D
@export var speedPath : float
@export var distance_max_vue = 200000
@export var TORQUE_FORCE = 600000.0
@export var MAX_SPEED = 400.0
@export var FORCE = 12000.0
@export var angle_dir = 0.5

func _ready() -> void:
	var node = $Corps
	node.trajet = self.path
	node.SPEED = self.speedPath
	node.distance_max_vue = self.distance_max_vue
	node.TORQUE_FORCE = self.TORQUE_FORCE
	node.MAX_SPEED = self.MAX_SPEED
	node.FORCE = self.FORCE
	node.angle_dir = self.angle_dir

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	var node = $Corps
	node.trajet = self.path
	node.SPEED = self.speedPath
	node.distance_max_vue = self.distance_max_vue
	node.TORQUE_FORCE = self.TORQUE_FORCE
	node.MAX_SPEED = self.MAX_SPEED
	node.FORCE = self.FORCE
	node.angle_dir = self.angle_dir
