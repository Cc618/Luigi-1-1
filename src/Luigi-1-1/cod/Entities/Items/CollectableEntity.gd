extends PhysicsBody2D

#	A collectable item
# * Childs:
# - CollisionShape2D
# !!! Don't forget to set contact_monitor to true and contacts_reported > 0



func _ready():
	connect("body_entered", self, "_on_Collectable_collect")


func _on_Collectable_collect(body):
	print("ok")
	if body.name == "Player":
		_on_player_collect()

		# Remove
		queue_free()


# Virtual
func _on_player_collect():
	pass
