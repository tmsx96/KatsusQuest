extends Area2D

export(String) var nextLevel = null

"""
verifica se foi o personagem que tocou na bandeira, para poder mudar de cena,
e zera o score parcial
"""

func _on_Bandeira_body_entered(body):
	if body.is_in_group("player"):
		Global.earned_score = 0
		get_tree().change_scene(nextLevel)
		