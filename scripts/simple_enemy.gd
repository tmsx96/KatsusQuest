extends KinematicBody2D

onready var Player = get_parent().get_node("Player")
var GRAVITY = 10
const SPEED = 100
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var is_entered = null
#var porsuit = 0
var dir = 0
var react_time = 400
var next_direction = 1 #era 0
var next_dir_time = 0
var is_dead = false

func _ready():
	pass
	
func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	$Timer.start()
	
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
			#print("borda")
			next_direction = next_direction * -1
			$RayCast2D.position.x *= -1
			
		velocity = move_and_slide(velocity, FLOOR)


#depois de dois segundos, o enemy sai da tela
func _on_Timer_timeout():
	queue_free()
