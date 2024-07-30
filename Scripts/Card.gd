extends Sprite2D

@export var card : String

var order = 0

var isSelected = false
var returningHome = false
var click_offset: Vector2
var home_position: Vector2
var target_position = null
var current_page = 0
var border_offset = 70


func _ready():
	load_page_content_sprite()


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		isSelected = false


func _physics_process(delta):
	z_index = Global.get_z_index("card") + order
	if isSelected:
		get_mouse_location_in_bounds()
		global_position = lerp(global_position, get_mouse_location_in_bounds(), 25 * delta)
	elif returningHome:
		if within_range(home_position, position):
			returningHome = false
		else:
			position = lerp(position, home_position, 15 * delta)


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and _is_top_most_sprite():
		click_offset = position - get_global_mouse_position()
		isSelected = true
		Global.set_z_indecies("card")


func set_target_position(new_position : Vector2):
	target_position = new_position


func get_mouse_location_in_bounds():
	return get_global_mouse_position().clamp(Vector2(border_offset, border_offset), 
				 Vector2(3840 - border_offset, 2160 - border_offset)) + click_offset

func set_card(card_code):
	card = card_code
	load_page_content_sprite()

func load_page_content_sprite():
	texture = load("res://Textures/Cards/" + card + ".png")


func within_range(target, actual):
	return actual.distance_to(target) < 0.1


func _is_top_most_sprite():
	var mouse_position = get_viewport().get_mouse_position()
	var highest_z_index = -1
	var top_most_sprite = null

	for sprite in get_tree().get_nodes_in_group("Papers"):
		if _get_sprite_global_rect(sprite).has_point(mouse_position):
			if sprite.z_index > highest_z_index:
				highest_z_index = sprite.z_index
				top_most_sprite = sprite

	return top_most_sprite == self


func _get_sprite_global_rect(sprite):
	var size = sprite.texture.get_size() * sprite.scale
	if sprite.rotation_degrees != 0:
		var new_size = Vector2(size.y, size.x)
		size = new_size
	var calc_position = sprite.global_position - (size / 2)
	return Rect2(calc_position, size)

