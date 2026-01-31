extends Node2D
@onready var light = $PointLight2D

func _ready() -> void:
	light.draw_texture_rect_region()
