extends "State.gd"


const ACCELERATION = 15
const MAX_SPEED = 220
const JUMP_FORCE = -420

const AIR_FRICTION = .07
const SHORT_JUMP_FRICTION = .2
const GROUND_FRICTION = .3

const BLINKING_COUNTDOWN = .125

var is_moving = false

var is_blinking = false
var blinking_timer = 0


func _on_leave():
	set_blinking(false)


func _update(dt):
	# Action
	if Input.is_action_just_pressed("action"):
		action()
	
	# Animation
	if is_blinking:
		blinking_timer += dt

		# We update the blink
		if blinking_timer >= BLINKING_COUNTDOWN:
			blinking_timer -= BLINKING_COUNTDOWN
			player.sprite.visible = !player.sprite.visible


func _pre_update_physics(dt):
	# Reset
	is_moving = false

	# Inputs
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")

	# Horizontal movement
	if !(left && right):
		if left:
			is_moving = true
			
			if player.vel.x > -MAX_SPEED:
				player.vel.x -= ACCELERATION
			# Max
			else:
				player.vel.x = -MAX_SPEED

		if right:
			is_moving = true
			
			if player.vel.x < MAX_SPEED:
				player.vel.x += ACCELERATION
			# Max
			else:
				player.vel.x = MAX_SPEED

	# Ground behaviour
	if player.is_on_floor():
		# Jump
		if Input.is_action_just_pressed("ui_up"):
			jump()
	
		# Ground friction
		elif !is_moving:
			player.vel.x *= 1 - GROUND_FRICTION

	else:
		# Air friction
		if !is_moving:
			player.vel.x *= 1 - AIR_FRICTION	
			
		# Jump (vertical) friction
		if !Input.is_action_pressed("ui_up") && player.vel.y < 0:
			player.vel.y *= 1 - SHORT_JUMP_FRICTION


func _post_update_physics(dt):
	# Check death
	if player.position.y > 0:
		player.set_state(player.state_dead)

		# Don't update after
		return
	
	# Update collisions
	if player.is_on_floor() || player.is_on_ceiling():
		player.vel.y = 0

	if player.is_on_wall():
		player.vel.x = 0

	# Flip the sprite
	if player.sprite.flip_h:
		if player.vel.x > 0:
			player.sprite.flip_h = false
	else:
		if player.vel.x < 0:
			player.sprite.flip_h = true


func jump(play_sound = true):
	"""
		To jump
	"""
	player.vel.y = JUMP_FORCE
	
	if play_sound:
		# Play the small or big jump sound effect
		if player.evolution == player.EvolutionType.SMALL:
			Audio.play("Jump")
		else:
			Audio.play("BigJump")


func set_blinking(blinking):
	if blinking == false:
		player.sprite.visible = true

	is_blinking = blinking


func action():
	"""
		The action executed when we press space.
	"""
	# Fire ball
	if player.evolution == player.EvolutionType.FLOWER:
		Audio.play("Fire")
		Items.spawn(player.position, "FireBall")














