extends KinematicBody2D

var _gravity = 0
var _movement = Vector2()


func shoot(dir_force, proj_grav):
	_movement = dir_force
	_gravity = proj_grav
	set_physics_process(true)


func _physics_process(delta):
	_movement.y += delta * _gravity
	move_and_slide(_movement)


