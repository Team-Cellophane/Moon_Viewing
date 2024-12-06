extends Sprite2D

@export var card : String
@export var play_click_on_ready = true

@onready var _asp_click1 = $AudioStreamPlayer2DClick1
@onready var _asp_click2 = $AudioStreamPlayer2DClick2
@onready var _asp_click3 = $AudioStreamPlayer2DClick3
@onready var _asp_pick1 = $AudioStreamPlayer2DPick1
@onready var _asp_pick2 = $AudioStreamPlayer2DPick2
@onready var _asp_pick3 = $AudioStreamPlayer2DPick3
@onready var _shadow_sprite2d = $ShadowSprite2D

var order = 0

var isSelected = false
var returningHome = false
var click_offset: Vector2
var home_position: Vector2
var target_position = null
var current_page = 0
var border_offset = 70


func _ready():
	if (play_click_on_ready):
		play_click()
	load_page_content_sprite()
	$"..".move_child(self, $"..".get_child_count())


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if (isSelected):
			_shadow_sprite2d.visible = false
			play_click()
		isSelected = false


func _physics_process(delta):
	z_index = Global.get_z_index("card") + get_index() + 1
	if isSelected:
		_shadow_sprite2d.visible = true
		z_index = 301
		get_mouse_location_in_bounds()
		global_position = lerp(global_position, get_mouse_location_in_bounds(), 25 * delta)
	elif returningHome:
		if within_range(home_position, position):
			returningHome = false
		else:
			position = lerp(position, home_position, 15 * delta)


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and _is_top_most_sprite():
		play_pick()
		click_offset = position - get_global_mouse_position()
		isSelected = true
		Global.set_z_indecies("card")
		$"..".move_child(self, $"..".get_child_count())

func play_click():
	var audio_stream_player = get_random_click_asp()
	audio_stream_player.pitch_scale = Global.get_rand_pitch_scale()
	audio_stream_player.play()
	
func get_random_click_asp():
	var r = randf()
	if r < 1.0/3.0 :
		return _asp_click1
	elif r > 2.0/3.0 :
		return _asp_click2
	else:
		return _asp_click3
		
func play_pick():
	var audio_stream_player = get_random_pick_asp()
	audio_stream_player.pitch_scale = Global.get_rand_pitch_scale()
	audio_stream_player.play()
	
func get_random_pick_asp():
	var r = randf()
	if r < 1.0/3.0 :
		return _asp_pick1
	elif r > 2.0/3.0 :
		return _asp_pick2
	else:
		return _asp_pick3

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
