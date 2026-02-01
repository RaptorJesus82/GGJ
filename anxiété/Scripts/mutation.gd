extends StaticBody2D
@onready var corps = $"../../Corps"
func seen():
	corps.stress_increase()
