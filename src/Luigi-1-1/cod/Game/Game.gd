extends Node

# The main singleton that handles all other singletons and properties

const CAMERA_ZOOM = .25

const GRAVITY = 1000
const FLOOR_NORMAL = Vector2(0, -1)

const COLLISION_LAYER_GROUND = 1
const COLLISION_LAYER_PLAYER = 1 << 1
const COLLISION_LAYER_POWER_UP = 1 << 2
const COLLISION_LAYER_ENEMY = 1 << 3

var player = null
var camera = null

# Camera's bounds relative to world coordinates
var camera_bound_left = 0
var camera_bound_right = 0



func _process(dt):
	update_camera_bounds()


func update_camera_bounds():
	"""
		Updates camera_bound_right and camera_bound_left
	"""
	var side_length = OS.window_size.x * .5 * Game.CAMERA_ZOOM

	camera_bound_right = camera.get_camera_screen_center().x + side_length 
	camera_bound_left = camera.get_camera_screen_center().x - side_length
