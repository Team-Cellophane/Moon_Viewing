extends ColorRect

@onready var _animation_player = $AnimationPlayer
@onready var _cicada_animation_player = $AudioStreamPlayerCicada/CicadaAnimationPlayer
var button_clicked = false
var _cicadas_playing = false

signal submit_recipe

func _ready():
	if (Global.scene_number == 0):
		_cicada_animation_player.play("Fade_In")
		_cicadas_playing = true
		_animation_player.play("3Long_Fade_In")
	else:
		_animation_player.play("2Fade_In")
		if (Global.get_current_recipe() == ""):
			_cicada_animation_player.play("Fade_In")
			_cicadas_playing = true
		if (Global.get_current_recipe() == "credits"):
			await MusicPlayer.finished
			await get_tree().create_timer(90).timeout
			_cicada_animation_player.play("Fade_In")
			_cicadas_playing = true
	
func transition_to_next_scene():
	if button_clicked:
		return
	button_clicked = true
	if (Global.get_current_recipe() == ""):
		MusicPlayer.play_scene_sting()
	else:
		MusicPlayer.play_scene_chord()
	if (_cicadas_playing):
		_cicada_animation_player.play("Fade_Out")
		_cicadas_playing = false
	# Plays the Fade animation and wait until it finishes
	_animation_player.play("1Fade_Out")
	if Global.get_current_recipe() != "":
		submit_recipe.emit()
	await _animation_player.animation_finished
	# Changes the scene
	Global.go_to_next_scene()

# Submit button
func _on_button_pressed():
	transition_to_next_scene()
