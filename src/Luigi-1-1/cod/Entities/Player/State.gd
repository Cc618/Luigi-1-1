extends Node

# Base (abstract) class for a player state



var player = null



func _state_init(player):
	"""
		When the player is ready
	"""
	self.player = player


func _on_enter():
	"""
		When the player change to this state
	"""
	pass


func _on_leave():
	"""
		When the player change to another state
	"""
	pass


func _update(dt):
	"""
		At each frame
	"""
	pass

	
func _pre_update_physics(dt):
	"""
		Before that the physics of the player are updated
	"""
	pass


func _post_update_physics(dt):
	"""
		After that the physics of the player are updated
	"""
	pass
	