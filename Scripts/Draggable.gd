extends Sprite2D

@export var is_letter = false
@export var is_decipher = false#TODO make this an enum
@export var landscape = false
@export var is_draggable = true
@export var min_button_enabled = true

@onready var _animation_player = $AnimationPlayer
@onready var _content_sprite2d = $Content_Sprite2D
@onready var _salutation_sprite2d = $Salutation_Sprite2D2
@onready var _prev_button = $Prev_Button
@onready var _next_button = $Next_Button
@onready var _min_button = $Min_Button

var isOpen = false
var isSelected = false
var returningHome = false
var click_offset: Vector2
var home_position: Vector2
var target_position = null
var current_page = 0
var border_offset = 70


func _ready():
	_min_button.visible = min_button_enabled
	home_position = position
	load_page_content_sprite()
	


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		isSelected = false


func _physics_process(delta):
	z_index = Global.get_z_index(name)
	if isSelected:
		get_mouse_location_in_bounds()
		global_position = lerp(global_position, get_mouse_location_in_bounds(), 25 * delta)
	elif returningHome:
		if within_range(home_position, position):
			returningHome = false
		else:
			position = lerp(position, home_position, 15 * delta)
	elif (!is_draggable and target_position != null and !within_range(target_position, position)):
		global_position = lerp(global_position, target_position, 25 * delta)


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and _is_top_most_sprite():
		click_offset = position - get_global_mouse_position()
		isSelected = is_draggable
		Global.set_z_indecies(name)
		do_open()


func _on_min_button_pressed():
	returningHome = true
	isOpen = false
	if landscape:
		_animation_player.play("Page_Shrink_Landscape")
	else:
		_animation_player.play("Page_Shrink")


func _on_prev_button_pressed():
	current_page -= 1
	load_page_content_sprite()


func _on_next_button_pressed():
	current_page += 1
	load_page_content_sprite()


func do_open():
	if not isOpen:
		if landscape:
			_animation_player.play("Page_Expand_Landscape")
		else:
			_animation_player.play("Page_Expand")
		isOpen = true


func do_close():
	if isOpen:
		if landscape:
			_animation_player.play("Page_Shrink_Landscape")
		else:
			_animation_player.play("Page_Shrink")
		isOpen = false


func set_target_position(new_position : Vector2):
	target_position = new_position


func get_mouse_location_in_bounds():
	return get_global_mouse_position().clamp(Vector2(border_offset, border_offset), 
				 Vector2(3840 - border_offset, 2160 - border_offset)) + click_offset


func load_page_content_sprite():
	var resource_path = build_resource_path(current_page)
	if ResourceLoader.exists(resource_path):
		_content_sprite2d.texture = load(resource_path)
		_prev_button.visible = ResourceLoader.exists(build_resource_path(current_page - 1))
		_next_button.visible = ResourceLoader.exists(build_resource_path(current_page + 1))
		
	if (is_letter and landscape and current_page == 0):
		_salutation_sprite2d.visible = true
		if (Global.previous_recipe_correct):
			_salutation_sprite2d.texture = load("res://Textures/Salutations/salutation-0.png")
		else:
			_salutation_sprite2d.texture = load("res://Textures/Salutations/salutation-1.png")
	else:
		_salutation_sprite2d.visible = false


func build_resource_path(page):
	var prefix
	if (is_letter):
		prefix = Global.get_current_letter_path()
	elif (is_decipher):
		prefix = Global.get_current_decipher_path()
	else:
		prefix = "Guides/guide"
	return str("res://Textures/", prefix, "-", page, ".png")


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
	var sprite_position = sprite.global_position - (size / 2)
	return Rect2(sprite_position, size)

