extends Node2D

@onready var _base_button = $RecipeScroll_Node2D/Scroll_Sprite2D/Base_Button
@onready var _ingredient_one = $"RecipeScroll_Node2D/Scroll_Sprite2D/Ingredient-1_Node2D"
@onready var _ingredient_two = $"RecipeScroll_Node2D/Scroll_Sprite2D/Ingredient-2_Node2D"
@onready var _ingredient_three = $"RecipeScroll_Node2D/Scroll_Sprite2D/Ingredient-3_Node2D"
@onready var _ingredient_four = $"RecipeScroll_Node2D/Scroll_Sprite2D/Ingredient-4_Node2D"
@onready var _ingredient_five = $"RecipeScroll_Node2D/Scroll_Sprite2D/Ingredient-5_Node2D"
@onready var _ingredient_six = $"RecipeScroll_Node2D/Scroll_Sprite2D/Ingredient-6_Node2D"
@onready var _correct_text = $CorrectText
@onready var _incorrect_text = $IncorrectText
@onready var _animation_player = $Drawer_Node2D/Drawer_AnimationPlayer

var drawer_open = false
var potion_base_oil = true

func _on_button_pressed():
	pass
	#Global.go_to_next_scene()
	#if (_recipe_entry.text == "w109,42"):
		#_correct_text.visible = true
		#_incorrect_text.visible = false
	#else:
		#_incorrect_text.visible = true
		#_correct_text.visible = false

func _on_ingredient_button_pressed(slot_pressed):
	print(slot_pressed.name)


func _on_handle_button_pressed():
	if drawer_open:
		_animation_player.play_backwards("Drawer_Open")
	else:
		_animation_player.play("Drawer_Open")
	drawer_open = !drawer_open


func _on_base_button_pressed():
	if potion_base_oil:
		_base_button.texture_normal = load("res://Textures/Ingredients/water.png")
		_base_button.texture_hover = load("res://Textures/Ingredients/water_hover.png")
	else:
		_base_button.texture_normal = load("res://Textures/Ingredients/oil.png")
		_base_button.texture_hover = load("res://Textures/Ingredients/oil_hover.png")
	potion_base_oil = !potion_base_oil
