extends Node2D

@onready var _base_button = $RecipeScroll_Node2D/Scroll_Sprite2D/Base_Button
@onready var _recipe_scroll = $RecipeScroll_Node2D/Scroll_Sprite2D
@onready var _animation_player = $Drawer_Node2D/Drawer_AnimationPlayer
@onready var _remove_button_info = $Drawer_Node2D/Remove_Button/Info_Node2D

var drawer_open = false
var potion_base_oil = true
var selected_slot: Node2D

func build_and_submit_recipe():
	var final_recipe
	if potion_base_oil:
		final_recipe = "o"
	else:
		final_recipe = "w"
	
	for n in range(1, 6, 1):
		var ingredient = _recipe_scroll.get_child(n).get_ingredient_definition()
		if ingredient != null:
			final_recipe += str(",", ingredient)
	
	Global.submit_recipe(final_recipe)

func _on_handle_button_pressed():
	if drawer_open:
		_animation_player.play_backwards("Drawer_Open")
		selected_slot = null
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


func _on_ingredient_slot_selected(selected_node, event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				selected_slot = selected_node
				if !drawer_open:
					_animation_player.play("Drawer_Open")
					drawer_open = true
			MOUSE_BUTTON_RIGHT:
				selected_node.set_ingredient(-1, null)
				selected_node._on_button_mouse_exited()
				selected_slot = null


func _on_ingredient_selected(ingredient_index, ingredient_texture):
	if selected_slot == null:
		return
	selected_slot.set_ingredient(ingredient_index, ingredient_texture)


func _on_remove_button_mouse_entered():
	_remove_button_info.visible = true


func _on_remove_button_mouse_exited():
	_remove_button_info.visible = false


func _on_remove_button_pressed():
	if selected_slot == null:
		return
	selected_slot.set_ingredient(-1, null)
	selected_slot = null
