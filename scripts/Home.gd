extends Button

#se o botao "home" for pressionado, a cena é mudada para a principal
func _on_home_pressed():
	Global.reset_lives()
	Global.reset_score()
	get_tree().change_scene("res://scenes/MainMenu.tscn")
