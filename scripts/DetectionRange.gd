extends Area2D

func _on_DetectionRange_body_entered(body):
	if body.is_in_group("player"):
		var ref = weakref(body)