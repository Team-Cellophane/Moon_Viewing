extends Node2D

signal slot_selected

@export var next_slot: Node2D

@onready var _ingredient = $Ingredient_Sprite2D
@onready var _label = $X_TextLabel
@onready var _quantity = $Quantity_SpinBox
@onready var _button = $Ingredient_Sprite2D/Ingredient_Button
@onready var _info = $Node2D
@onready var _info_ingredient_sprite = $Node2D/Card/Ingredient
@onready var _info_index = $Node2D/Index
@onready var _info_text = $Node2D/Name

var ingredient_index = -1

func _on_ingredient_slot_button_pressed(event):
	slot_selected.emit(self, event)
	

func _on_button_mouse_entered():
	if ingredient_index > 0:
		_info.visible = true


func _on_button_mouse_exited():
	_info.visible = false


func get_next_slot():
	return next_slot


func set_focus():
	_button.grab_focus()


func set_ingredient(index, new_texture):
	var ingredient = Global.ingredients[index - 1]
	
	ingredient_index = index
	
	_ingredient.texture = new_texture
	_info_ingredient_sprite.texture = new_texture
	
	_info_text.text = "[center]" 
	if Global.get_current_scene_number() > 7:
		_info_text.text += ingredient.measure + " " 
	_info_text.text += ingredient.display_name
	_info_index.text = "[center]Index: " + str(index)
	
	if Global.get_current_scene_number() > 7:
		_label.visible = index > 0
		_quantity.visible = index > 0
	
	if next_slot != null:
		next_slot.visible = index > 0


func remove_ingredient():
	_on_button_mouse_exited()
	var current_index = ingredient_index
	var current_texture = _ingredient.texture
	var current_quantity = _quantity.value
	var next_node_ingredient = [-1, null, 1]
	if next_slot != null:
		next_node_ingredient = next_slot.remove_ingredient()
		
	set_ingredient(next_node_ingredient[0], next_node_ingredient[1])
	_quantity.value = next_node_ingredient[2]
	return [current_index, current_texture, current_quantity]


func get_ingredient_definition():
	if ingredient_index == -1:
		return null
	var quantity = _quantity.value
	return str(ingredient_index, "x", quantity)
