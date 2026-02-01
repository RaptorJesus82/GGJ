extends StaticBody2D
@onready var corps = $"../.."
func seen():
	corps.stress_increase()
