extends KinematicBody2D
class_name Tsygan

func process(ARGS):
	
	if ARGS.Player == null:
		return
	
	
	# --- MOVEMENT --- #
	
	var move_vec = Vector2()
	var direction_map = [
		["move_up",    [  0, -1 ]], 
		["move_right", [  1,  0 ]], 
		["move_down",  [  0,  1 ]], 
		["move_left",  [ -1,  0 ]]
	]
	
	for direction in direction_map:
		if Input.is_action_pressed(direction[0]):
			move_vec.x += direction[1][0] 
			move_vec.y += direction[1][1] 
	
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * ARGS.ENV.SPEED * ARGS.DELTA)
	
	# --- MOVEMENT --- #
	
	
	# --- LOOK_DIR --- #
	
	var look_vec = ARGS.Player.global_position - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("shoot"):
		var coll = ARGS.ENV.RAY.get_collider()
		if ARGS.ENV.RAY.is_colliding() and coll.has_method("die"):
			coll.die()
	
	# --- LOOK_DIR --- #