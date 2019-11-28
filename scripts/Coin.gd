extends Area2D

signal coin_collected

#se o player entrar na area da moeda, emite-se um sinal e limpa ela da cena
func _on_moeda_body_entered(body : PhysicsBody2D)->void:
	if body.is_in_group("player"):
		emit_signal("coin_collected")
		queue_free()