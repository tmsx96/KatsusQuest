extends KinematicBody2D


# Proj_angle
export(float) var proj_angle = 350 setget set_bomb_angle
# Proj_speed
export(int) var proj_speed = 8
# Bomb gravity
export(int) var proj_grav = 5
# Bomb scene:
export(PackedScene) var bomb_scene
# Bomb spawn
export(NodePath) var bomb_spawn_path
onready var bomb_spawn = get_node(bomb_spawn_path)
# Dir_force
var dir_force = Vector2()
# Delay
export(float) var shoot_delay = 2
var waited = 0
# Can_shoot
var can_shoot = true


# Called when the node enters the scene tree for the first time.
func _ready():
	update_dir_force()
	set_process(true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_bomb_angle(value):
	proj_angle = clamp(value, 0, 359)

func update_dir_force():
	dir_force = Vector2(cos(proj_angle*(PI/180)), sin(proj_angle*(PI/180))) * proj_speed

func _process(delta):
	if(can_shoot && waited > shoot_delay):
		shoot()
		waited = 0
	elif(waited <= shoot_delay):
		waited += delta


func shoot():
	var bomb = bomb_scene.instance()
	bomb.set_global_pos(bomb_spawn.get_global_pos())
	bomb.shoot(dir_force, proj_grav)
	get_parent().addchild(bomb)