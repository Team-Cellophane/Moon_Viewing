extends Node

var scene_number = 0
var current_scene = null
var previous_recipe_correct = true
var current_highest_z_index = 0
var scenes = 	[	SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-1",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-1","w109,42"),
					SceneInfo.new("res://Scenes/main.tscn","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-2","o51,93,17,32"),
					SceneInfo.new("res://Scenes/main.tscn","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-3","o7,7,11,132"),
					SceneInfo.new("res://Scenes/main.tscn","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-4","w59,125,45,15,58,32"),
					SceneInfo.new("res://Scenes/main.tscn","","")
				]

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func go_to_next_scene():
	scene_number += 1
	call_deferred("_deferred_go_to_current_scene")

func get_next_z_index():
	current_highest_z_index += 1
	return current_highest_z_index

func _deferred_go_to_current_scene():
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(get_current_scene_path())

	# Instance the new scene.
	current_scene = s.instantiate()
	
	get_tree().root.add_child(current_scene)
	
func get_current_letter_path():
	print(str(scene_number) + " letter = " + scenes[scene_number].letter)
	return scenes[scene_number].letter
	
func get_current_recipe():
	print(str(scene_number) + " letter = " + scenes[scene_number].recipe)
	return scenes[scene_number].recipe
	
func get_current_scene_path():
	print(str(scene_number) + " letter = " + scenes[scene_number].path)
	return scenes[scene_number].path

class SceneInfo:
	
	var path : String
	var letter : String
	var recipe : String
	
	func _init(p, l, r):
		path = p
		letter = l
		recipe = r
