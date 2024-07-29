extends Sprite2D

@export var _ingredient_index : int = -1

@onready var _ingredient_sprite = $Sprite2D
@onready var _info = $Sprite2D/Node2D
@onready var _info_ingredient_sprite = $Sprite2D/Node2D/Card/Ingredient
@onready var _info_index = $Sprite2D/Node2D/Index
@onready var _info_text = $Sprite2D/Node2D/Name

var ingredient

func _ready():
	ingredient = Global.ingredients[_ingredient_index]
	_ingredient_sprite.texture = load("res://Textures/Ingredients/" + ingredient.name + ".png")
	_info_ingredient_sprite.texture = _ingredient_sprite.texture
	_info_text.text = "[center]" + ingredient.measure + " " + ingredient.display_name
	_info_index.text = "[center]Index: " + str(_ingredient_index + 1)
	


func _on_button_mouse_entered():
	_info.visible = true


func _on_button_mouse_exited():
	_info.visible = false
