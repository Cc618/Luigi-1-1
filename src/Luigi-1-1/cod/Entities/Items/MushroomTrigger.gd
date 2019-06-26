extends "res://cod/Entities/Items/Collectable.gd"


func _on_player_collect():
	get_parent()._on_player_collect()
