extends KinematicBody2D

onready var Player = get_parent().get_node("Player")
#onready var explosionStarter = $ExplosionStarter/CollisionShape2D
#onready var Pos2D = $Position2D 
const SHURIKEN = preload("res://scenes/RangedEnemyWeapon.tscn")

var GRAVITY = 10
const SPEED = 100
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var is_entered = null
#var porsuit = 0
var dir = 0
#var react_time = 400
var next_direction = 1 #era 0
var next_dir_time = 0
var is_dead = false

func dead(var dead_time):
	if(is_dead == false): #impede que o inimigo fique em cena se estiver sendo atacado constantemente pela shurikens
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("dead")
		$DeathTimer.wait_time = dead_time
		$DeathTimer.start()

func get_random_number():
    randomize()
    return (randi()%16 + 5)/10.0

#implementar os intervalos entre os tiros de maneira randomica
func shooting():
	var shuriken = SHURIKEN.instance()
	#shuriken.set_texture("default1", "res://sprites/enemies/Ranged Enemy/Projectile-1.png")
	if sign($Position2D.position.x) == 1:
		shuriken.set_shuriken_direction(1)
	else:
		shuriken.set_shuriken_direction(-1)
		
	get_parent().add_child(shuriken)
	shuriken.position = $Position2D.global_position
	
func _on_ShootTimer_timeout():
	if(is_dead == false):
		shooting()
		$ShootTimer.wait_time = get_random_number()

func _physics_process(delta):
	if is_dead == false:
		#velocity.x = SPEED * direction
		velocity.x = SPEED * next_direction
		
		$AnimatedSprite.play("walk")
		
		velocity.y += GRAVITY
		
		if next_direction == 1:
			$AnimatedSprite.flip_h = false
		elif next_direction == -1:
			$AnimatedSprite.flip_h = true
		
		if $RayCast2D.is_colliding() == false:
			next_direction = next_direction * -1
			$RayCast2D.position.x *= -1
			$Position2D.position.x *= -1
		
			
		if is_entered:
			if Player.position.x < position.x and next_direction != -1:
				#velocity.x = velocity.x * 3
				#direction = direction * -1
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
				$AnimatedSprite.flip_h = true
				next_direction = -1
				#next_dir_time = OS.get_ticks_msec() + react_time
				
				
			elif Player.position.x > position.x and next_direction != 1:
				#velocity.x = velocity.x * 3
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
				$AnimatedSprite.flip_h = false
				next_direction = 1
				#next_dir_time = OS.get_ticks_msec() + react_time
				
			if OS.get_ticks_msec() >  next_dir_time:
				dir = next_direction
			velocity.x = SPEED * next_direction	
			#velocity.x = dir * 250
		velocity = move_and_slide(velocity, FLOOR)

#alterar para desativar o modo perseguição quando o jogador sair da plataforma do enemy
func _on_DetectionRange_body_entered(body):
	if body.is_in_group("player"):
		is_entered = body

#depois de dois segundos, o enemy sai da tela
func _on_DeathTimer_timeout():
	queue_free()
	
func _on_ExplosionStarter_body_entered(body):
	if body.is_in_group("player"):
		Global.lost_life()
		dead(0.1)
		#colocar animação de explosão






