extends Sprite2D

@export var _ingredient_index : int = -1

@onready var _ingredient_sprite = $Sprite2D
@onready var _info = $Sprite2D/Node2D
@onready var _info_ingredient_sprite = $Sprite2D/Node2D/Card/Ingredient
@onready var _info_index = $Sprite2D/Node2D/Index
@onready var _info_text = $Sprite2D/Node2D/Name
@onready var _asp_knock = $AudioStreamPlayer2DKnock

signal ingredient_selected

var ingredient

func _ready():
	ingredient = Global.ingredients[_ingredient_index - 1]
	_ingredient_sprite.texture = load("res://Textures/Ingredients/" + ingredient.name + ".png")
	_info_ingredient_sprite.texture = _ingredient_sprite.texture
	_info_text.text = "[center]" 
	if Global.get_current_scene_number() > 7:
		_info_text.text += ingredient.measure + " " 
	_info_text.text += ingredient.display_name
	_info_index.text = "[center]Index: " + str(_ingredient_index)


func _on_button_mouse_entered():
	_info.visible = true


func _on_button_mouse_exited():
	_info.visible = false


func _on_button_pressed():
	_asp_knock.pitch_scale = Global.get_rand_pitch_scale()
	_asp_knock.play()
	ingredient_selected.emit(_ingredient_index, _ingredient_sprite.texture)
