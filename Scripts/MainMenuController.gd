extends Node2D


@onready var _title_moon = $Node/TitleMoon
@onready var _title_viewing = $Node/TitleViewing
@onready var _title_animation_player = $Node/TitleAnimationPlayer
@onready var _play_button = $PlayButton
@onready var _background = $Background
@onready var _background_animation_player = $Background/BackgroundAnimationPlayer
@onready var _letter = $PlaintextLetter

@onready var _continue_button = $ContinueButton

func _ready():
	if (Global.scene_number != 0):
		_title_moon.visible = false
		_title_viewing.visible = false
		#play music/ sfx
		_display_letter_or_continue()
	else:
		_title_animation_player.play("Fade_In")
		_background_animation_player.play("Blur_Off")
		await _title_animation_player.animation_finished
		_play_button.visible = true

func _display_letter_or_continue():
	await get_tree().create_timer(5).timeout
	if (Global.get_current_letter_path() != ""):
		_background_animation_player.play("Blur_On")
		_letter.do_open()
		_letter.set_target_position(Vector2(1920, 1080))
	_continue_button.visible = true
	

func _on_play_button_pressed():
	_play_button.visible = false
	_title_animation_player.play("Fade_Out")
	_background_animation_player.play("Blur_On")
	await _background_animation_player.animation_finished
	_letter.do_open()
	_letter.set_target_position(Vector2(1920, 1080))
	_continue_button.visible = true
