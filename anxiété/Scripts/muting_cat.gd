extends Node2D

@export var mutations : Array[Node2D]
var remainingMutation : Array[Node2D]
var currentMutation : Array[Node2D]
var stress : float =1.5
var mut
@export var stress_on_sight : float =0.001
signal muted_up
signal muted_down
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for mut in mutations:
		mut.hide()
		remainingMutation.append(mut)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if int(stress) > len(currentMutation):
		mut = remainingMutation.pop_at(remainingMutation.find(remainingMutation.pick_random()))
		mut.show()
		currentMutation.append(mut)
		muted_up.emit(mut)
	elif int(stress) < len(currentMutation) :
		mut = currentMutation.pop_at(currentMutation.find(currentMutation.pick_random()))
		mut.hide()
		remainingMutation.append(mut)
		muted_down.emit(mut)

func stress_increase():
	stress += stress_on_sight
