extends Node

var scene_number = 0
var current_scene = null
var previous_recipe_correct = true
var current_highest_z_index = 0
var scenes = 	[	SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-1","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-1","Decipher/decipher-1","w109,42"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-2","Decipher/decipher-1","o51,93,17,32"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-3","Decipher/decipher-1","o7,7,11,132"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-4","Decipher/decipher-1","w59,125,45,15,58,32"),
					SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-2","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-5","Decipher/decipher-2","w109,42"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-6","Decipher/decipher-2","o51,93,17,32"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-7","Decipher/decipher-2","o7,7,11,132"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-8","Decipher/decipher-2","w59,125,45,15,58,32"),
					SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-3","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-9","Decipher/decipher-3","w109,42"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-10","Decipher/decipher-3","o51,93,17,32"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-11","Decipher/decipher-3","o7,7,11,132"),
					SceneInfo.new("res://Scenes/main.tscn","","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-12","Decipher/decipher-3","w59,125,45,15,58,32"),
					SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-4","",""),
					SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-13","Decipher/decipher-3","w59,125,45,15,58,32"),#TODO create decipher 4
					SceneInfo.new("res://Scenes/main.tscn","","","")
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
	return scenes[scene_number].letter
	
func get_current_decipher_path():
	return scenes[scene_number].decipher
	
func get_current_recipe():
	return scenes[scene_number].recipe
	
func get_current_scene_path():
	return scenes[scene_number].path

class SceneInfo:
	
	var path : String
	var letter : String
	var decipher : String
	var recipe : String
	
	func _init(p, l, d, r):
		path = p
		letter = l
		decipher = d
		recipe = r
