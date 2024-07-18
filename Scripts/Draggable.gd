extends Sprite2D

var isSelected = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		isSelected = event.pressed


func _physics_process(delta):
	if isSelected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
