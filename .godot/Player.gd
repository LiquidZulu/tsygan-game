extends KinematicBody2D

var move_vec_p = Vector2()
onready var PLAYER_ENV = {
	SPEED = 300,
	RAY   = $RayCast2D
}

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("ENEMY", "set_player", self)

func _physics_process(delta):
	
	
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
			
			move_vec_p = move_vec
	
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * PLAYER_ENV.SPEED * delta)
	get_node("Hull").rotation = atan2(move_vec_p.y, move_vec_p.x)
	
	# --- MOVEMENT --- #
	
	
	# --- LOOK_DIR --- #
	
	var look_vec = get_global_mouse_position() - global_position
	get_node("turret").rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("shoot"):
		var coll = PLAYER_ENV.RAY.get_collider()
		if PLAYER_ENV.RAY.is_colliding() and coll.has_method("die"):
			coll.die()
	
	# --- LOOK_DIR --- #


func die():
	get_tree().reload_current_scene()