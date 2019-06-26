extends "State.gd"


const JUMP_FORCE = -400


func _on_enter():
	# Stop the player and make it jump
	player.vel.x = 0
	player.vel.y = JUMP_FORCE
	
	# Remove collisions
	player.collision_layer = 0
	player.collision_mask = 0

	# Change the sound
	Audio.set_music("Death", self, "on_music_stops")


func _on_leave():
	################## TODO: Change evolution
	# Restore collisions
	player.collision_layer = player.default_collision_layer
	player.collision_mask = player.default_collision_mask


func on_music_stops():
	Audio.set_music("Theme")
	
	# Respawn the player
	player.respawn()
