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
		if (Global.get_current_recipe() == ""):
			_cicada_animation_player.play("Fade_In")
			_cicadas_playing = true
		_animation_player.play("2Fade_In")
	
func transition_to_next_scene():
	if button_clicked:
		return
	if (_cicadas_playing):
		_cicada_animation_player.play("Fade_Out")
		_cicadas_playing = false
	button_clicked = true
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
