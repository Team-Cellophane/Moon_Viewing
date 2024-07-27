extends Node2D

@onready var _base_button = $"Base_Button"
@onready var _ingredient_one = $"Ingredient-1_Node2D"
@onready var _ingredient_two = $"Ingredient-2_Node2D"
@onready var _ingredient_three = $"Ingredient-3_Node2D"
@onready var _ingredient_four = $"Ingredient-4_Node2D"
@onready var _ingredient_five = $"Ingredient-5_Node2D"
@onready var _ingredient_six = $"Ingredient-6_Node2D"
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
