extends Area2D

const SPEED = 100
var velocity = Vector2()
var direction = 1 #direita

func set_shuriken_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	
func _physics_process(delta):
	velocity.x = SPEED * delta * direction * 5
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	#destrói o objeto (shuriken)
	queue_free()
	
	#se o shuriken estiver mto proximo do body do player, vai dar bug
func _on_Shuriken_body_entered(body):
	#se o nome entre aspas estiver no campo "name" do body, execute dead() desse body
	if "Kamikaze" in body.name:
		#print("entrou")
		body.dead(2)
	elif "RangedEnemy" in body.name:
		body.dead(2)
	queue_free() #deleta o inimigo depois do timer executar
