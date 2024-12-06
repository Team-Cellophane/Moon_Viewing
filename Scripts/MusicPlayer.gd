extends AudioStreamPlayer

func play_scene_sting():
	set_stream(load("res://Audio/Music/sting"+Global.get_current_scene_music_squence()+".wav"))
	play()
	
func play_scene_chord():
	stream = load("res://Audio/Music/chord"+Global.get_current_scene_music_squence()+".wav")
	play()
	
func play_Moon_Viewing():
	stream = load("res://Audio/Music/Moon Viewing.wav")
	play()
