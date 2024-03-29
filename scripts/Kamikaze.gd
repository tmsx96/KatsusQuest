extends KinematicBody2D

onready var Player = get_parent().get_node("Player")
#onready var kamikazeBody = $KamikazeBody
#onready var explosionStarter = $ExplosionStarter/CollisionShape2D
var GRAVITY = 10
const SPEED = 100
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var is_entered = null
#var porsuit = 0
var dir = 0
var react_time = 400
var next_direction = 1 #era 0
var next_dir_time = 0
var is_dead = false
var player_detected = false

func dead(var dead_time):
	if(is_dead == false): #impede que o inimigo fique em cena se estiver sendo atacado constantemente pela shurikens
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("dead")
		
		$DeathDelay.wait_time = dead_time
		$DeathDelay.start()


func _physics_process(delta):
	if is_dead == false:
		#velocity.x = SPEED * direction
		velocity.x = SPEED * next_direction
		
		if(player_detected == false):
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("running")
		velocity.y += GRAVITY
	#elif  is_dead == false and player_detected != false:
		#$AnimatedSprite.play("running")
		"""
		if is_on_wall():
			direction = direction * -1
			$RayCast2D.position.x *= -1
		"""
		
		
		#patrulha do enemy
		"""
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		if $RayCast2D.is_colliding() == false:
			direction = direction * -1
			$RayCast2D.position.x *= -1
		"""
		"""
		if $RayCast2D.is_colliding() == false:
			direction = direction * -1
			$RayCast2D.position.x *= -1
		"""
		if next_direction == 1:
			$AnimatedSprite.flip_h = false
		elif next_direction == -1:
			$AnimatedSprite.flip_h = true
		
		if $RayCast2D.is_colliding() == false:
			#print("borda")
			next_direction = next_direction * -1
			$RayCast2D.position.x *= -1
		
			
		if is_entered:
			if player_detected == false:
				$DeathTimer.wait_time = 5.0
				$DeathTimer.start()
				
			player_detected = true
			if Player.position.x < position.x and next_direction != -1:
				$RayCast2D.position.x *= -1
				$AnimatedSprite.flip_h = true
				next_direction = -1
				next_dir_time = OS.get_ticks_msec() + react_time
				
				
			elif Player.position.x > position.x and next_direction != 1:
				$RayCast2D.position.x *= -1
				$AnimatedSprite.flip_h = false
				next_direction = 1
				next_dir_time = OS.get_ticks_msec() + react_time
				
			"""	
			elif Player.position.x == position.x and next_direction != 0:
				next_direction = 0
				next_dir_time = OS.get_ticks_msec() + react_time
			"""
			if OS.get_ticks_msec() >  next_dir_time:
				dir = next_direction
				
			velocity.x = dir * 250
			#print(velocity)
			
		velocity = move_and_slide(velocity, FLOOR)

#alterar para desativar o modo perseguição quando o jogador sair da plataforma do enemy
func _on_DetectionRange_body_entered(body):
	if body.is_in_group("player"):
		is_entered = body
		#porsuit+=1
		#print("entrou")

func _on_Timer_timeout():
	queue_free()
	print("hm")
	
func _on_ExplosionStarter_body_entered(body):
	if body.is_in_group("player"):
		Global.lost_life()
		dead(0.1)
		#colocar animação de explosão


func _on_DeathAfterPoursuitStarted_timeout():
	queue_free()
	print("ok")
