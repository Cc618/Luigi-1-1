extends StaticBody2D



func _ready():
	$Trigger.connect("body_entered", self, "on_trigger_enter")


func on_trigger_enter(body):
	"""
		When the player hits the block
	"""
	# If the player isn't small 
	if Game.player.evolution_priority > 1:
		# Sound
		Audio.play("Bricks")
	
		# Destroy
		queue_free()
