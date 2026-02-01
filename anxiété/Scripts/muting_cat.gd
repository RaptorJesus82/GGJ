extends Node2D

@export var mutations : Array[Node2D]
var remainingMutation : Array[Node2D]
var currentMutation : Array[Node2D]
var stress : float =1.5
var mut
var dead : bool = false
@export var stress_on_sight : float =0.001
@export var calming = 0.001
@export var stress_on_collide : float = 0.5
var seen : bool = false
var is_seen : bool = false
@onready var dialogueTimer = $DialogueInterval
@onready var dialogueLabel = $DisplayTextLocation/Label
var textes = [
	["Il faut que je sorte de là...",
	"en tout discrétion...",
	"héhé",
	"hop là",
	"tu n'as rien vu"],
	["Faut que je parte",
	"La honte...",
	"Faites que ça s'arrête",
	"J'aurais jamais dû venir"],
	["Ah !",
	"Pas ça...",
	"...",
	"Tu n'as rien vu"],
	["Aaaaah !",
	"Ne regardes pas !",
	"J'ai envie de mourir...",
	"Grrr !",
	"Ew...",
	"NON"]
]

signal muted_up
signal muted_down
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for mut in mutations:
		mut.hide()
		remainingMutation.append(mut)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if int(stress) > len(currentMutation) and len(remainingMutation)>0:
		mut = remainingMutation.pop_at(remainingMutation.find(remainingMutation.pick_random()))
		mut.show()
		currentMutation.append(mut)
		muted_up.emit(mut)
	elif int(stress) < len(currentMutation) :
		mut = currentMutation.pop_at(currentMutation.find(currentMutation.pick_random()))
		mut.hide()
		remainingMutation.append(mut)
		muted_down.emit(mut)
	if not seen and stress >= calming :
		stress -= calming
	else :
		seen = false
	if int(stress) > len(mutations):
		$Corps/mutationEpauleDroite.set_collision_layer_value(1, true)
		$Corps/mutationEpauleGauche.set_collision_layer_value(1, true)
		$Tete/mutationTete.set_collision_layer_value(1, true)
		$Queue/mutationQueue.set_collision_layer_value(1, true)
		dead=true
		

	if dialogueTimer.is_stopped() and randf() < 0.5*delta:
		updateLabel()

func updateLabel():
	dialogueTimer.start()
	if not is_seen:
		is_seen = false
	if not is_seen and stress < len(mutations) / 3:
		dialogueLabel.text = textes[0].pick_random()
	elif not is_seen:
		dialogueLabel.text = textes[1].pick_random()
	elif stress < len(mutations) / 2:
		dialogueLabel.text = textes[2].pick_random()
	else:
		dialogueLabel.text = textes[3].pick_random()

func clearLabel():
	dialogueLabel.text = ""

func stress_increase():
	stress += stress_on_sight
	seen = true
	if not is_seen:
		updateLabel()
	is_seen = true
	Timer


func _on_corps_body_entered(body: Node) -> void:
	if body.is_in_group("Enemies"):
		stress += stress_on_collide


func _on_dialogue_interval_timeout() -> void:
	clearLabel()
