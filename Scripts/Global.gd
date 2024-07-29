extends Node

var scene_number = 0
var current_scene = null
var previous_recipe_correct = true
var scenes
var ingredients

var max_z_index = 200
var letter_z_index = 200
var decipher_z_index = 150
var guide_z_index = 100
var card_z_index_start = 50

func _ready():
	set_scenes()
	set_ingredients()
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func submit_recipe(built_recipe):
	previous_recipe_correct = get_current_recipe() == built_recipe

func go_to_next_scene():
	scene_number += 1
	call_deferred("_deferred_go_to_current_scene")

func set_z_indecies(new_top_name: String):
	if (new_top_name == "card"):
		decrease_z_indicies_greater_than(card_z_index_start)
		card_z_index_start = max_z_index
	if (new_top_name == "Letter_Sprite2D"):
		decrease_z_indicies_greater_than(letter_z_index)
		letter_z_index = max_z_index
	if (new_top_name == "Decipher_Sprite2D"):
		decrease_z_indicies_greater_than(decipher_z_index)
		decipher_z_index = max_z_index
	if (new_top_name == "Guide_Sprite2D"):
		decrease_z_indicies_greater_than(guide_z_index)
		guide_z_index = max_z_index
		
		
func decrease_z_indicies_greater_than(z_index: int):
	letter_z_index = letter_z_index - 50 if letter_z_index > z_index else letter_z_index
	decipher_z_index = decipher_z_index - 50 if decipher_z_index > z_index else decipher_z_index
	guide_z_index = guide_z_index - 50 if guide_z_index > z_index else guide_z_index
	card_z_index_start = card_z_index_start - 50 if card_z_index_start > z_index else card_z_index_start

func get_z_index(object_name):
	if (object_name == "card"):
		return card_z_index_start
	if (object_name == "Letter_Sprite2D"):
		return letter_z_index
	if (object_name == "Decipher_Sprite2D"):
		return decipher_z_index
	if (object_name == "Guide_Sprite2D"):
		return guide_z_index
	return 0

func _deferred_go_to_current_scene():
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(get_current_scene_path())

	# Instance the new scene.
	current_scene = s.instantiate()
	
	get_tree().root.add_child(current_scene)

func get_current_scene_number():
	return scene_number

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
		
class Ingredient:
	
	var name : String
	var measure : String
	var display_name : String
	
	func _init(n, m, d):
		name = n
		measure = m
		display_name = d

func set_scenes():
	scenes = 	[		SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-1","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-1","Decipher/decipher-1","w,109,42"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-2","Decipher/decipher-1","o,51,93,17,32"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-3","Decipher/decipher-1","o,7,7,11,132"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-4","Decipher/decipher-1","w,59,125,45,15,58,32"),
						SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-2","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-5","Decipher/decipher-2","w,109,42"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-6","Decipher/decipher-2","o,51,93,17,32"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-7","Decipher/decipher-2","o,7,7,11,132"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-8","Decipher/decipher-2","w,59,125,45,15,58,32"),
						SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-3","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-9","Decipher/decipher-3","w,109,42"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-10","Decipher/decipher-3","o,51,93,17,32"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-11","Decipher/decipher-3","o,7,7,11,132"),
						SceneInfo.new("res://Scenes/main.tscn","","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-12","Decipher/decipher-3","w,59,125,45,15,58,32"),
						SceneInfo.new("res://Scenes/main.tscn","PlaintextLetters/plaintext-4","",""),
						SceneInfo.new("res://Scenes/table_scene.tscn","Letters/letter-13","Decipher/decipher-3","w,59,125,45,15,58,32"),#TODO create decipher 4
						SceneInfo.new("res://Scenes/main.tscn","","","")
					]

func set_ingredients():
	ingredients = 	[	Ingredient.new("maple_leaf","","Maple leaves"),
						Ingredient.new("manure","g","Manure"),
						Ingredient.new("goose_egg","","Goose eggs"),
						Ingredient.new("sparrow_egg","","Sparrow eggs"),
						Ingredient.new("belladonna","","Belladonna flowers"),
						Ingredient.new("paulownia","","Paulownia flowers"),
						Ingredient.new("bloodstone","","Bloodstone shards"),
						Ingredient.new("alkahest","ml","Alkahest"),
						Ingredient.new("nightshade","","Nightshade petals"),
						Ingredient.new("alum","g","Alum"),
						Ingredient.new("vitriol","mg","Vitriol"),
						Ingredient.new("distill_x_times","times","Distilled"),
						Ingredient.new("skunk_gland","","Skunk glands"),
						Ingredient.new("susuki_grass","","Susuki grass blades"),
						Ingredient.new("warbler_eye","","Warbler eyes"),
						Ingredient.new("powdered_mummy","mg","Powdered mummy"),
						Ingredient.new("bombardier_beetle","","Bombardier beetles"),
						Ingredient.new("rat_whisker","","Rat whiskers"),
						Ingredient.new("yeast","g","Yeast"),
						Ingredient.new("antimony","g","Antimony"),
						Ingredient.new("lapis_lazuli","","Lapis lazuli shards"),
						Ingredient.new("let_sit_in_moonlight_for_x_minutes","minutes","Sat in moonlight"),
						Ingredient.new("mistletoe","","Mistletoe cuts"),
						Ingredient.new("rose","","Rose petals"),
						Ingredient.new("cow_cud","ml","Cow cud"),
						Ingredient.new("iris","","Iris petals"),
						Ingredient.new("rosemary","","Rosemary cuts"),
						Ingredient.new("plum_tree_blossom","","Plum tree blossoms"),
						Ingredient.new("cicada","","Cicadas"),
						Ingredient.new("sand","pinches","Sand"),
						Ingredient.new("crane_beak","","Crane beak"),
						Ingredient.new("simmer_for_x_minutes","minutes","Simmered"),
						Ingredient.new("mandrake_root","g","Mandrake root"),
						Ingredient.new("ginseng","g","Ginseng"),
						Ingredient.new("butterfly","","Butterflies"),
						Ingredient.new("fox_glove","","Fox glove flowers"),
						Ingredient.new("lavender","","Lavender petals"),
						Ingredient.new("nickle","g","Nickle"),
						Ingredient.new("tin_dust","g","Tin dust"),
						Ingredient.new("stink_bug","","Stink bugs"),
						Ingredient.new("tobacco_leaf","","Tobacco leaves"),
						Ingredient.new("filter_through_cloth_x_times","times","Filtered through cloth"),
						Ingredient.new("pine_needles","pinches","Pine needles"),
						Ingredient.new("wasp_nest_husk","","Wasp nest husks"),
						Ingredient.new("deer_antler","","Deer antlers"),
						Ingredient.new("ammonia","ml","Ammonia"),
						Ingredient.new("cattail","","Cattail"),
						Ingredient.new("hemp","","Hemp leaves"),
						Ingredient.new("aqua_regia","ml","Aqua regia"),
						Ingredient.new("coral","","Coral chunks"),
						Ingredient.new("magnesia","g","Magnesium"),
						Ingredient.new("centrifugate_for_x_seconds","seconds","Centrifugated"),
						Ingredient.new("bezoar_stone","","Bezoar stone shards"),
						Ingredient.new("lithium","g","Lithium"),
						Ingredient.new("seaweed","","Seaweed cuts"),
						Ingredient.new("albedo","mg","Albedo"),
						Ingredient.new("grain_alcohol","ml","Grain alcohol"),
						Ingredient.new("poppy","","Poppy petals"),
						Ingredient.new("swallows_feather","","Swallow feathers"),
						Ingredient.new("salmon_roe","g","Salmon roe"),
						Ingredient.new("dragons_blood","ml","Dragon's blood"),
						Ingredient.new("stir_gently_for_x_seconds","seconds","Stirred gently"),
						Ingredient.new("dandelion","","Dandelion flowers"),
						Ingredient.new("bullet_ant","","Bullet ants"),
						Ingredient.new("lead","g","Lead"),
						Ingredient.new("hydragenum","mg","Hydragenum"),
						Ingredient.new("phoenix_feather","","Phoenix feathers"),
						Ingredient.new("quebrith","mg","Quebrith"),
						Ingredient.new("aether","mg","Aether"),
						Ingredient.new("sunflower","","Sunflower petals"),
						Ingredient.new("squid_ink_sac","","Squid ink sacs"),
						Ingredient.new("let_sit_in_sunlight_for_x_minutes","minutes","Sat in sunlight"),
						Ingredient.new("salt","pinches","Salt"),
						Ingredient.new("boar_tusk","","Boar tusks"),
						Ingredient.new("wisteria","","Wisteria petals"),
						Ingredient.new("vinegar","ml","Vinegar"),
						Ingredient.new("platypus_venom_gland","","Platypus venom gland"),
						Ingredient.new("virgins_blood","ml","Virgin's blood"),
						Ingredient.new("firefly","","Fireflies"),
						Ingredient.new("saffron","","Saffron petals"),
						Ingredient.new("cyanide","mg","Cyanide"),
						Ingredient.new("chill_for_x_minutes","minutes","In icebox"),
						Ingredient.new("wine","ml","Wine"),
						Ingredient.new("shark_tooth","","Shark teeth"),
						Ingredient.new("parsley","","Parsley cuts"),
						Ingredient.new("rebis","mg","Rebis"),
						Ingredient.new("cherry_tree_blossom","","Cherry tree blossoms"),
						Ingredient.new("brimstone","","Brimstone shards"),
						Ingredient.new("silver_dust","mg","Silver dust"),
						Ingredient.new("nigredo","mg","Nigredo"),
						Ingredient.new("mosquito","","Mosquitos"),
						Ingredient.new("stir_vigorously_for_x_seconds","seconds","Stirred vigorously"),
						Ingredient.new("snake_tongue","","Snake tongues"),
						Ingredient.new("ox_gall_liquid","ml","Ox gall liquid"),
						Ingredient.new("cocoa_beans","","Cocoa beans"),
						Ingredient.new("beeswax","g","Beeswax"),
						Ingredient.new("thyme","","Thyme cuts"),
						Ingredient.new("willow","","Willow leaves"),
						Ingredient.new("brandy","ml","Brandy"),
						Ingredient.new("potash","g","Potash"),
						Ingredient.new("snake_skin","","Snake skins"),
						Ingredient.new("steep_philosophers_stone_for_x_minutes","minutes","Steeped with philosopher's stone"),
						Ingredient.new("house_fly","","House flies"),
						Ingredient.new("realgar","mg","Realgar"),
						Ingredient.new("henbane","","Henbane flowers"),
						Ingredient.new("elderberry","","Elderberry cuts"),
						Ingredient.new("eagle_plume","","Eagle plumes"),
						Ingredient.new("toe_of_frog","","Frog toes"),
						Ingredient.new("honeybee","","Honeybees"),
						Ingredient.new("alfalfa","","Alfalfa flowers"),
						Ingredient.new("cats_eye","","Cat eyes"),
						Ingredient.new("boil_for_x_minutes","minutes","Boiled"),
						Ingredient.new("bismuth","","Bismuth shards"),
						Ingredient.new("vermillion","mg","Vermillion"),
						Ingredient.new("iron_oxide","g","Iron oxide"),
						Ingredient.new("baby_spider_vial","","Baby spiders"),
						Ingredient.new("sage","","Sage cuts"),
						Ingredient.new("peony","","Peony petals"),
						Ingredient.new("rubedo","mg","Rubedo"),
						Ingredient.new("moth","","Moths"),
						Ingredient.new("lespedeza","","Lespedeza flowers"),
						Ingredient.new("gun_powder","g","Gun powder"),
						Ingredient.new("ivory","g","Ivory"),
						Ingredient.new("lizards_leg","","Lizard legs"),
						Ingredient.new("eye_of_newt","","Newt eyes"),
						Ingredient.new("quicksilver","mg","Quicksilver"),
						Ingredient.new("sake","ml","Sake"),
						Ingredient.new("charcoal","g","Charcoal"),
						Ingredient.new("chrysanthemum","","Chrysanthemum petals"),
						Ingredient.new("earth_worm","","Eath worms"),
						Ingredient.new("truffle","","Truffle slivers"),
						Ingredient.new("shake_vigorously_for_x_seconds","seconds","Shaken vigorously"),
						Ingredient.new("honey","g","Honey"),
						Ingredient.new("tarantuala_leg","","Tarantula legs"),
						Ingredient.new("rabbits_foot","","Rabbit's feet"),
						Ingredient.new("yarrow","","Yarrow flowers"),
						Ingredient.new("arsenic","mg","Arsenic"),
						Ingredient.new("copper_oxide","g","Copper oxide"),
						Ingredient.new("ambergris","mg","Ambergris"),
						Ingredient.new("platinum_dust","mg","Platinum dust"),
						Ingredient.new("dilute_with_base","ml","Base"),
						Ingredient.new("gold","mg","Gold"),
						Ingredient.new("cinnabar","mg","Cinnabar"),
						Ingredient.new("mint","","Mint cuts")
					]
