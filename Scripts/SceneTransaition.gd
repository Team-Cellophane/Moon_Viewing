extends ColorRect

@onready var _animation_player = $AnimationPlayer

func _ready():
	_animation_player.play("Fade_In")
	
func transition_to_next_scene():
	# Plays the Fade animation and wait until it finishes
	_animation_player.play("Fade_Out")
	await _animation_player.animation_finished
	# Changes the scene
	Global.go_to_next_scene()


func _on_button_pressed():
	transition_to_next_scene()
