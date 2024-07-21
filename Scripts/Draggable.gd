extends Sprite2D

@export var content_prefix: String

@onready var _animation_player = $AnimationPlayer
@onready var _content_sprite2d = $Content_Sprite2D
@onready var _prev_button = $Prev_Button
@onready var _next_button = $Next_Button

var isOpen = false
var isSelected = false
var returningHome = false
var home_position: Vector2
var current_page = 0


func _ready():
	home_position = position
	load_page_content_sprite()
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		isSelected = false


func _physics_process(delta):
	if isSelected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	elif returningHome:
		if within_range(home_position, position):
			returningHome = false
		else:
			position = lerp(position, home_position, 15 * delta)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		isSelected = true
		if not isOpen:
			_animation_player.play("Page_Expand")
			isOpen = true


func _on_min_button_pressed():
	returningHome = true
	isOpen = false
	_animation_player.play("Page_Shrink")


func _on_prev_button_pressed():
	current_page -= 1
	load_page_content_sprite()


func _on_next_button_pressed():
	current_page += 1
	load_page_content_sprite()


func load_page_content_sprite():
	var resource_path = build_resource_path(current_page)
	if ResourceLoader.exists(resource_path):
		_content_sprite2d.texture = load(resource_path)
		_prev_button.visible = ResourceLoader.exists(build_resource_path(current_page - 1))
		_next_button.visible = ResourceLoader.exists(build_resource_path(current_page + 1))


func build_resource_path(page):
	return str("res://Textures/Letters/", content_prefix, "_", page, ".png")


func within_range(target, actual):
	return actual.distance_to(target) < 0.1

