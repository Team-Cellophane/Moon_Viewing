extends Sprite2D

@onready var _card_layer = $"../CardLayer"
@onready var _display = $Display
@onready var _display_card = $Display/Card
@onready var _audio_stream_player_reset1 = $AudioStreamPlayer2DResetSound1
@onready var _audio_stream_player_reset2 = $AudioStreamPlayer2DResetSound2
@onready var _audio_stream_player_select = $AudioStreamPlayer2DSelectSound

var _moused_over = false
var deck : Array[String]
var _num_cards_out = 0
var _selected_card = 0

func _ready():
	reset_deck()

func _physics_process(_delta):
	z_index = Global.get_z_index("card") + 49
	if (_moused_over and _is_top_most_sprite()):
		_display.visible = true
	else:
		_display.visible = false

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if !(event is InputEventMouseButton and event.pressed and _is_top_most_sprite()):
		return
	if  event.button_index == MOUSE_BUTTON_LEFT:
		if (deck.size() == 0):
			return
		var _card_prefab = load("res://Prefabs/card.tscn")
		var card = _card_prefab.instantiate()
		card.card = _display_card.card
		card.order = _num_cards_out
		deck.erase(_display_card.card)
		if (deck.size() == 0):
			_display_card.visible = false
		else:
			_selected_card = posmod(_selected_card, deck.size())
			_display_card.set_card(deck[_selected_card])
		card.position = position + Vector2(-178,0)
		_card_layer.add_child(card)
		_num_cards_out += 1
		Global.set_z_indecies("card")
		return
	
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		if (deck.size() != 0):
			_selected_card = posmod(_selected_card - 1, deck.size())
			_display_card.set_card(deck[_selected_card])
			_audio_stream_player_select.pitch_scale = Global.get_rand_pitch_scale() + 0.1
			_audio_stream_player_select.play()
		Global.set_z_indecies("card")
		return
		
	if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		if (deck.size() != 0):
			_selected_card = posmod(_selected_card + 1, deck.size())
			_display_card.set_card(deck[_selected_card])
			_audio_stream_player_select.pitch_scale = Global.get_rand_pitch_scale() - 0.1
			_audio_stream_player_select.play()
		Global.set_z_indecies("card")
		return
		
	if event.button_index == MOUSE_BUTTON_RIGHT:
		reset_deck()
		Global.set_z_indecies("card")
		return
		
func get_random_reset_player():
	return _audio_stream_player_reset1 if randf() > 0.5 else _audio_stream_player_reset2
		
func reset_deck():
	if (_num_cards_out != 0):
		var audio_stream_player = get_random_reset_player()
		audio_stream_player.pitch_scale = Global.get_rand_pitch_scale()
		audio_stream_player.play()
	deck = ["1b","1p","1l","1r","2a","2p","2l","2r","3b","3p","3l","3r","4a","4p","4l","4r","5a","5p","5l","5r","6a","6p","6l","6r","7a","7p","7l","7r","8b","8a","8l","8r","9s","9p","9l","9r","Aa","Ap","Al","Ar","Bb","Ba","Bp","Bs","Cb","Cl","Cs","Cr"]
	for child in _card_layer.get_children():
		child.queue_free()
	_num_cards_out = 0
	_selected_card = 0
	_display_card.set_card(deck[_selected_card])
	_display_card.visible = true


func _on_area_2d_mouse_entered():
	_moused_over = true


func _on_area_2d_mouse_exited():
	_moused_over = false
	
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
