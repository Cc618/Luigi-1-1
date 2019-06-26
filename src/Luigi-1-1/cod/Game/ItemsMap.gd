extends TileMap

# To spawn the items


func _ready():
	# Iterate through all items
	for pos in get_used_cells():
		var tile_name = tile_set.tile_get_name(get_cellv(pos))

		# We add a semi block because entities are instantiated from the center of the tile
		Items.spawn(map_to_world(pos) + Vector2(8, 8), tile_name)

	# Delete this
	queue_free()
