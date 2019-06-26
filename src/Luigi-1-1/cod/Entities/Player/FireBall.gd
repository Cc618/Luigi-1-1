extends KinematicBody2D


const SPEED = 120

var vel = Vector2(SPEED, 0)


func _physics_process(dt):
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


func _on_enemy_hit(b):
	print("ok")
#	Game.player.evolve(Game.player.EvolutionType.NORMAL)

	queue_free()
