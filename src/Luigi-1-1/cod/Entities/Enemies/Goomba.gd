extends KinematicBody2D


const SPEED = 40

var vel = Vector2(-SPEED, 0)


func _physics_process(dt):
	# Test if the goomba is in camera's boudnaries
	if position.x - 8 < Game.camera_bound_right && position.x + 8 > Game.camera_bound_left:
		# Physics update
		move_and_slide(vel, Game.FLOOR_NORMAL)
	
		# Ground check
		if is_on_floor():
			vel.y = 0
		else:
			# Gravity
			vel.y += Game.GRAVITY * dt
	
		# Bounce
		if is_on_wall():
			vel.x = -vel.x
	
		# Destroy
		if position.y > 0:
			queue_free()


func _on_player_crush(b):
	"""
		The player crushes the goomba
	"""
	# If the player falls
	if Game.player.vel.y > 0:
		Game.player.state_alive.jump(false)
		Audio.play("Crush")
		
		queue_free()


func _on_player_hit(b):
	"""
		When the goomba hits the player
	"""
	# The player can be hit by the goomba
	if Game.player.collision_mask & Game.COLLISION_LAYER_ENEMY != 0:
		Game.player.hit()
