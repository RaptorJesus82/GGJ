extends Node2D

@export var mutations : Array[Node2D]
var remainingMutation : Array[Node2D]
var currentMutation : Array[Node2D]
var stress : int = 1
var mut
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for mut in mutations:
		mut.hide()
		remainingMutation.append(mut)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stress > len(currentMutation):
		mut = remainingMutation.pop_at(remainingMutation.find(remainingMutation.pick_random()))
		mut.show()
		currentMutation.append(mut)
	elif stress < len(currentMutation) :
		mut = currentMutation.pop_at(currentMutation.find(currentMutation.pick_random()))
		mut.hide()
		remainingMutation.append(mut)
