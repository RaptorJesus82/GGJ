extends CharacterBody2D
class_name ennemy
@export var SPEED = 300.0
@export var trajet : PathFollow2D

func _process(delta: float) -> void:
	trajet.progress += SPEED*delta
	self.position=trajet.position
