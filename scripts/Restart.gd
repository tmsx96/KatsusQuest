extends Button

func _on_restart_pressed():
		Global.reset_lives()
		Global.reset_score()
		get_tree().change_scene("res://scenes/Level1.tscn")
	
