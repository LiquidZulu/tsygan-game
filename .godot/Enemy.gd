extends KinematicBody2D

var Enemy             = preload("Tsygan.gd")
var player            = null
onready var ENEMY_ENV = {
	SPEED = 300,
	RAY   = $RayCast2D
}

func _ready():
	Enemy.new()
	add_to_group("ENEMY")
	yield(get_tree(), "idle_frame")

func _physics_process(delta):
	Enemy.process({
		ENV    = ENEMY_ENV,
		DELTA  = delta,
		Player = player
	})


func die():
	get_tree().reload_current_scene()

func set_opponent(o):
	player = o