extends Node

var enemies = [
	preload("res://scenes/enemies/asteroid.tscn"),
	preload("res://scenes/enemies/asteroid_big.tscn")
	]


func _on_enemy_timer_timeout():
	var spawner = enemies.pick_random().instantiate()
	spawner.position = Vector2(randi_range(0,160), 0)
	$Level.add_child(spawner)
