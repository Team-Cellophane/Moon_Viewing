extends Node2D


@onready var _title = $Node/Title
@onready var _title_animation_player = $Node/TitleAnimationPlayer
@onready var _play_button = $PlayButton
@onready var _background_animation_player = $Background/BackgroundAnimationPlayer
@onready var _credits_animation_player = $Node2/CreditsAnimationPlayer
@onready var _letter = $PlaintextLetter
@onready var _asp_cicada_animation_player = $AudioStreamPlayerCicada/CicadaAnimationPlayer

@onready var _continue_button = $ContinueButton

func _ready():
	if (Global.scene_number != 0 && Global.get_current_recipe() != "credits"):
		_title.visible = false
		_display_letter_or_continue()
	elif (Global.get_current_recipe() == "credits"):
		_do_end_credits()
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
	MusicPlayer.play_scene_chord()
	_play_button.visible = false
	_title_animation_player.play("Fade_Out")
	_background_animation_player.play("Blur_On")
	await _background_animation_player.animation_finished
	_letter.do_open()
	_letter.set_target_position(Vector2(1920, 1080))
	_continue_button.visible = true
	
func _do_end_credits():
	_title_animation_player.play("Fade_In")
	await MusicPlayer.finished
	MusicPlayer.play_Moon_Viewing()
	_credits_animation_player.play("Credits")
	await get_tree().create_timer(4).timeout
	_title_animation_player.play("Fade_Out")
	_background_animation_player.play("Blur_On")
	await _credits_animation_player.animation_finished
	_background_animation_player.play("Blur_Off")
