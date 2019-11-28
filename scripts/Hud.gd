extends Control

onready var SCORE = $CanvasLayer/Score
onready var LIVES = $CanvasLayer/Lives
onready var KUNAIS = $CanvasLayer/Kunais

func _physics_process(delta):
	SCORE.set_text(str(Global.score))
	LIVES.set_text(str(Global.lives))
	KUNAIS.set_text(str(Global.ranged_weapon))