extends Camera2D
var max_offset = Vector2(30, 30)
var target="../Corps"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shake()
		
func shake():
	offset.x = max_offset.x * $"../../..".stress * randf_range(-1, 1)*0.2
	offset.y = max_offset.y * $"../../..".stress * randf_range(-1, 1)*0.2
