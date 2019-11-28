extends Area2D

signal kunai_collected

func _on_kunai_body_entered(body : PhysicsBody2D)->void:
	if body.is_in_group("player"):
		emit_signal("kunai_collected")
		queue_free()

