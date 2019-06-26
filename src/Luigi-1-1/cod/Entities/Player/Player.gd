extends KinematicBody2D


# Regions to change the sprite
export(Rect2) var region_small
export(Rect2) var region_normal
export(Rect2) var region_flower


onready var sprite = $Sprite
onready var shape = $Shape
onready var safe_time_timer = $SafeTimeTimer

onready var spawn_position = position
onready var default_collision_layer = collision_layer
onready var default_collision_mask = collision_mask

# States
onready var state_alive = $States/Alive
onready var state_dead = $States/Dead
# The state to actually update
var current_state = null

var vel = Vector2()

enum EvolutionType {
	SMALL,		# Smaller
	NORMAL		# Mushroom
	FLOWER		# Fire Flower
}
# 1 = Small, 2 = Mushroom, 3 = Other power ups
var evolution_priority = 1
var evolution = EvolutionType.SMALL


## 1 = Small, 2 = Mushroom, 3 = Other power ups
#var evolution_priority = 3 ########## 1
#var evolution = EvolutionType.FLOWER ########## SMALL


func _ready():
	# Singleton
	Game.player = self
	Game.camera = $Camera
	
	# Init states
	state_alive._state_init(self)
	state_dead._state_init(self)
	set_state(state_alive)


func _process(dt):
	current_state._update(dt)
	
	if Input.is_action_just_pressed("reset"):
		# Reload the scene
		get_tree().reload_current_scene()


func _physics_process(dt):
	current_state._pre_update_physics(dt)

	# Gravity
	vel.y += Game.GRAVITY * dt

	# Update position
	move_and_slide(vel, Game.FLOOR_NORMAL)

	current_state._post_update_physics(dt)


func set_state(state):
	"""
		Change the state of the player
	"""
	if current_state != null:
		current_state._on_leave()

	current_state = state
	current_state._on_enter()


func kill():
	"""
		Kills the player
	"""
	set_state(state_dead)


func respawn():
	"""
		Respawns the player
	"""
	# Reset attributes
	position = spawn_position
	vel = Vector2(0, 0)
	set_evolution(EvolutionType.SMALL, 1)
	
	# Change state
	set_state(state_alive)


func evolve(evolution):
	"""
		Change the power up of the player if this evolution is better than the current
	"""
	# Detect the priority of the evolution
	var priority = 3
	match evolution:
		EvolutionType.SMALL:
			priority = 1
		EvolutionType.NORMAL:
			priority = 2

	# The player will evolve
	if priority > evolution_priority:
		Audio.play("PowerUp")

		set_evolution(evolution, priority)


func hit():
	"""
		The inverse of evolve, if the player is small we kill the player
	"""
	evolution_priority -= 1
	
	# Death
	if evolution_priority <= 0:
		kill()
	# Small
	else:
		# Sound effect
		Audio.play("Pipe")
		
		# Invincibility
		# Remove collisions with enemies
		collision_mask &= ~Game.COLLISION_LAYER_ENEMY
		state_alive.set_blinking(true)
		safe_time_timer.start()
		
		# Small
		if evolution_priority == 1:
			set_evolution(EvolutionType.SMALL, evolution_priority)
		# Normal
		else:
			set_evolution(EvolutionType.NORMAL, evolution_priority)


func set_evolution(evolution, priority):
	"""
		Change the evolution instantly
	!!! To evolve, don't call this method, use evolve()
	"""
	evolution_priority = priority	
	self.evolution = evolution
	
	match evolution:
		EvolutionType.SMALL:
			sprite.region_rect = region_small
			change_shape_scale(1)

		EvolutionType.NORMAL:
			sprite.region_rect = region_normal
			change_shape_scale(2)
			
		EvolutionType.FLOWER:
			sprite.region_rect = region_flower
			change_shape_scale(2)


func change_shape_scale(scale):
	"""
		Updates the scale (the factor of the height) of the shape and the position.
	"""
	############### TODO: Only y ?
	position.y += (shape.scale.y - scale) * 8
	shape.scale.y = scale


func _on_SafeTimeTimer_timeout():
	state_alive.set_blinking(false)
	
	# Restore enemies collisions
	collision_mask |= Game.COLLISION_LAYER_ENEMY
