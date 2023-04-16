extends Node

var score = 0
var level = 1
var enemies = [
	preload("res://scenes/asteroid.tscn"),
	preload("res://scenes/asteroid.tscn"),
	preload("res://scenes/asteroid_big.tscn")
	]


func _on_enemy_timer_timeout():
	var spawner = enemies.pick_random().instantiate()
	spawner.position = Vector2(randi_range(0,160), 0)
	$Level.add_child(spawner)


func _on_level_child_exiting_tree(node):
	if ("Asteroid" in node.name and node.by_shoot == true):
		score += node.score
		update_score()


func update_score():
	if (score >= level*100000):
		$EnemyTimer.wait_time -= 0.1 + (0.3 ** level)
		$Level/BackGround.texture = load("res://assets/bg"+str(level%3)+".png")
		level += 1
	$Control/Panel/Score.text = str(score)
