extends Node2D

signal slot_selected

@onready var _label = $RichTextLabel
@onready var _quantity = $Recipe_Entry

var ingredient_index = -1

func _on_ingredient_slot_button_pressed():
	slot_selected.emit(self)
	

func set_ingredient_index(index):
	ingredient_index = index
	if Global.get_current_scene_number() > 7:
		_label.visible = true
		_quantity.visible = true


func get_ingredient_definition():
	if ingredient_index == -1:
		return null
	return str(ingredient_index) + _quantity.text
