extends Node2D

#Incrementa o score parcial a partir do retorno da função _increase_score()
func _on_moeda_coin_collected():
	Global.score+=10

func _on_kunai_kunai_collected():
	Global.ranged_weapon += 5
