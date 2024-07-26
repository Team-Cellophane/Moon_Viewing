extends Sprite2D

@export var content_prefix: String
@export var is_letter = false
@export var landscape = false

@onready var _animation_player = $AnimationPlayer
@onready var _content_sprite2d = $Content_Sprite2D
@onready var _prev_button = $Prev_Button
@onready var _next_button = $Next_Button

var isOpen = false
var isSelected = false
var returningHome = false
var click_offset: Vector2
var home_position: Vector2
var current_page = 0
var border_offset = 70


func _ready():
	home_position = position
	load_page_content_sprite()
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		isSelected = false


func _physics_process(delta):
	if isSelected:
		get_mouse_location_in_bounds()
		global_position = lerp(global_position, get_mouse_location_in_bounds(), 25 * delta)
	elif returningHome:
		if within_range(home_position, position):
			returningHome = false
		else:
			position = lerp(position, home_position, 15 * delta)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		click_offset = position - get_global_mouse_position()
		isSelected = true
		z_index = Global.get_next_z_index()
		if not isOpen:
			if landscape:
				_animation_player.play("Page_Expand_Landscape")
			else:
				_animation_player.play("Page_Expand")
			isOpen = true


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


func get_mouse_location_in_bounds():
	return get_global_mouse_position().clamp(Vector2(border_offset, border_offset), 
				 Vector2(3840 - border_offset, 2160 - border_offset)) + click_offset


func load_page_content_sprite():
	var resource_path = build_resource_path(current_page)
	if ResourceLoader.exists(resource_path):
		_content_sprite2d.texture = load(resource_path)
		_prev_button.visible = ResourceLoader.exists(build_resource_path(current_page - 1))
		_next_button.visible = ResourceLoader.exists(build_resource_path(current_page + 1))


func build_resource_path(page):
	var prefix = Global.get_current_letter_path() if is_letter else content_prefix
	return str("res://Textures/", prefix, "-", page, ".png")


func within_range(target, actual):
	return actual.distance_to(target) < 0.1

