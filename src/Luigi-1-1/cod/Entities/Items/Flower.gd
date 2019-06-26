extends "Collectable.gd"


func _on_player_collect():
	Game.player.evolve(Game.player.EvolutionType.FLOWER)
