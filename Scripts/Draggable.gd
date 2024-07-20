extends Sprite2D

var isSelected = false
var returningHome = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		isSelected = false


func _physics_process(delta):
	if isSelected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	elif returningHome:
		if (-0.1 < position.x and 0.1 > position.x) and (-0.1 < position.y and 0.1 > position.y):
			returningHome = false
		else:
			position = lerp(position, Vector2(0, 0), 25 * delta)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		isSelected = true


func _on_letter_min_button_pressed():
	returningHome = true

