extends Node2D


@onready var _recipe_entry = $Recipe_Entry
@onready var _correct_text = $CorrectText
@onready var _incorrect_text = $IncorrectText

func _on_button_pressed():
	pass
	#Global.go_to_next_scene()
	#if (_recipe_entry.text == "w109,42"):
		#_correct_text.visible = true
		#_incorrect_text.visible = false
	#else:
		#_incorrect_text.visible = true
		#_correct_text.visible = false
