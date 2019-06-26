extends StaticBody2D


# The sprite region of the blank block
export(Rect2) var blank_region


# String : Coin, Mushroom, Flower or Up
var type = null


func init_suffix(s):
	type = s


func _ready():
	$Trigger.connect("body_entered", self, "on_trigger_enter")


func on_trigger_enter(body):
	"""
		When the player enters within the trigger
	"""
	# Disable trigger
	$Trigger.queue_free()

	# Change sprite
	$Sprite.region_rect = blank_region

	# The type depends on the evolution of the player
	if type == "Mushroom":
		# Flower when the player is not small
		if Game.player.evolution_priority > 1:
			type = "Flower"

	# Spawn item
	Items.spawn(Vector2(position.x, position.y - 16), type)
	
	# Sound
	if type != "Coin":
		Audio.play("PowerUpSpawn")
