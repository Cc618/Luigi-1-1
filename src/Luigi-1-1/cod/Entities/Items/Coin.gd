extends "Collectable.gd"


func _on_player_collect():
	Audio.play("Coin")
