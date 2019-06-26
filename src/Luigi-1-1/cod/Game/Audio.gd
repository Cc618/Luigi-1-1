extends Node2D


var current_music = null


func _ready():
	set_music("Theme")
	

func play(sound_name):
	find_node(sound_name).play()
	
	
func set_music(music_name, sender = null, on_stop_callback_id = null):
	"""
		Change the current music to play.
	- sender can be null with on_stop_callback
	- on_stop_callback_id is the id of a function called when the music stops
	"""
	if current_music:
		current_music.stop()

	# Find music
	current_music = find_node(music_name)
	
	# Callback
	if sender != null:
		current_music.connect("finished", sender, on_stop_callback_id)
	
	# Play music
	current_music.play()
