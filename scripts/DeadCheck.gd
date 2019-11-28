extends Area2D

export(String) var currentLevel = null

#verifica se o jogador tocou o shape
func _on_DeadCheck_body_entered(body):
	if body.is_in_group("player"):
		Global.clear_earned_score()
		Global.lost_life()
		
		#se não tem mais vidas, o score e as vidas são resetadas e muda-se pra tela de game over
		if(Global.lives == 0):
			Global.reset_lives()
			Global.reset_score()
			get_tree().change_scene("res://scenes/GameOver.tscn")
		else:
			get_tree().change_scene(currentLevel)

