extends Node

const LIVES = 3
var score = 0 
var lives = LIVES
var earned_score = 0 #score parcial da fase
var ranged_weapon = 5
export(String) var menu_scene = null

#incrementa o score com base no "value" do item coletado e retorna o "value" (pq retorna?)
func increase_score(value):
	score += value
	#print("Score: " + str(score))
	return value

#retira uma vida do player
func lost_life():
	lives-=1

#limpa o score obtido na fase, caso o player morra
func clear_earned_score():
	#print("Score: "+ str(score), " Earned: " + str(earned_score))
	score += -earned_score
	earned_score = 0

#incrementa o score obtido na fase atual
func increase_earned_score(levelScore):
	earned_score+= levelScore

#reseta o score total
func reset_score():
	score = 0

#reseta as vidas de acordo com a constante LIFES
func reset_lives():
	lives = LIVES

func ranged_weapon_used():
	ranged_weapon -= 1

func get_ranged_weapon_():
	return ranged_weapon