extends KinematicBody2D

const UP = Vector2(0, -1)
var move = Vector2()
#var stage = null
#pre carrega a cena na memória para ser usada quando se desejar
const SHURIKEN = preload("res://scenes/Shuriken.tscn")

onready var groundRay = get_node("ground_ray")
export var speedX    = 100
export var jumpForce = -200
export var gravity   = 200
const extraJumps  = 2
var jumpsCounter = 0
var count = 0


func _physics_process(delta):
	move.y += gravity * delta
	$AnimatedSprite.playing = true
	
	if Global.lives == 0:
		Global.reset_score()
		get_tree().change_scene("res://scenes/GameOver.tscn")
	
	if Input.is_action_pressed("ui_left"):
		move.x = -speedX
		$AnimatedSprite.animation = "walking"
		$AnimatedSprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite.animation = "walking"
		move.x = speedX
		$AnimatedSprite.flip_h = false
		#se o position2D está no lado esquerdo, mude para o lado direito
		if sign($Position2D.position.x) == -1: 
			$Position2D.position.x *= -1
	else:
		$AnimatedSprite.animation = "idle"
		move.x = 0
	
	#if Input.is_key_pressed(KEY_R):
	
	#limitar um shuriken por clique
	if Input.is_action_just_pressed("shoot"):
		if(Global.get_ranged_weapon_() > 0):
			var shuriken = SHURIKEN.instance() #cria uma shuriken na memoria
			if sign($Position2D.position.x) == 1:
				shuriken.set_shuriken_direction(1)
			else:
				shuriken.set_shuriken_direction(-1)
			get_parent().add_child(shuriken)
			shuriken.position = $Position2D.global_position
			Global.ranged_weapon_used()
		
	#usado no doublejump do player: se o personagem estiver no chão, o "jumpsCounter" é zerado
	if groundRay.is_colliding():
		#print("esta colidindo" + str(count))
		jumpsCounter = 0
		move.y = 0
		#count+=1
	
	#se o estiver fora do chão e a quantidade de pulos dados for inferior ao extraJumps, o personagem pula
	if Input.is_action_just_pressed("ui_accept") and jumpsCounter < extraJumps:
		move.y = jumpForce
		jumpsCounter+=1
	
	#print("X:", position.x, "Y:", position.y)
	
	move_and_slide(move, UP)
