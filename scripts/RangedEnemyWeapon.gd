extends Area2D

const SPEED = 100
var velocity = Vector2()
var direction = 1 #direita
#onready var ANIM_SPRITE = $AnimatedSprite

func set_shuriken_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

#func set_texture(nome_textura, frame):
	#ANIM_SPRITE.get_sprite_frames().add_animation(nome_textura)
	#ANIM_SPRITE.get_sprite_frames().add_frame(nome_textura, frame, 0)
	
func _physics_process(delta):
	velocity.x = SPEED * delta * direction * 5
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	#destrói o objeto (shuriken)
	queue_free()
	
	#se o shuriken estiver mto proximo do body do player, vai dar bug
func _on_Shuriken_body_entered(body):
	#se o nome entre aspas estiver no campo "name" do body, execute dead() desse body
	if body.is_in_group("player"):
		Global.lost_life()