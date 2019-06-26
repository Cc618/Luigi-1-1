extends Node

# Spawns the items, the name is either Id or Id_Type
# Ex: Coin spawns a coins and Surprise_Coin spawns a surprise with a coin inside
# while Surprise_Mushroom spawn instead a mushroom


const ITEMS = {
	"Bricks": preload("res://scn/Entities/Bricks.tscn"),
	"Coin": preload("res://scn/Entities/Coin.tscn"),
	"Mushroom": preload("res://scn/Entities/Mushroom.tscn"),
	"Flower": preload("res://scn/Entities/Flower.tscn"),
	"Surprise": preload("res://scn/Entities/Surprise.tscn"),
	"Up": preload("res://scn/Entities/UpMushroom.tscn"),
	"Goomba": preload("res://scn/Entities/Goomba.tscn"),
	"FireBall": preload("res://scn/Entities/FireBall.tscn"),
}


func spawn(pos, name):
	"""
		Instantiates the object with the name 'name'
	"""
	# Detect whether it's a composed name
	var parts = name.split("_", true, 1)

	var item = ITEMS[parts[0]].instance()

	# Add the item to the level
	item.position = pos
	get_node("/root/Main").call_deferred("add_child", item)

	# Set suffix
	if len(parts) == 2:
		item.init_suffix(parts[1])
