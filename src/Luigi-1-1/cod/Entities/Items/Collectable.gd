extends Area2D

#	A collectable item
# * Childs:
# - CollisionShape2D



func _ready():
	connect("body_entered", self, "_on_Collectable_collect")


func _on_Collectable_collect(body):
	if body.name == "Player":
		_on_player_collect()

		# Remove
		queue_free()


# Virtual
func _on_player_collect():
	pass
