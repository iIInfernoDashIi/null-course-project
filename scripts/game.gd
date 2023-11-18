extends Node

var total_score := 0

var level := 1
var difficulty := 1
var bosses := 0

var general_enemies = [
	preload("res://scenes/enemies/asteroid.tscn"),
	preload("res://scenes/enemies/asteroid.tscn"),
	preload("res://scenes/enemies/asteroid_big.tscn"),
	]

var boss_enemies = [
	preload("res://scenes/enemies/boss_1.tscn"),
	preload("res://scenes/enemies/boss_2.tscn"),
	preload("res://scenes/enemies/boss_3.tscn"),
	]

func _ready():
	$Level.child_entered_tree.connect(_on_level_child_entered_tree)

func _on_enemy_timer_timeout():
	var spawner = general_enemies.pick_random().instantiate()
	spawner.get_node("Area").position = Vector2(randi_range(0,160), 0)
#	if randi() % 100 < 10:
#		spawner.position = Vector2($Level/Player.position.x, 0)
	$Level.add_child(spawner)

func _on_level_child_entered_tree(node):
	if node.get_child(0).has_signal("scored"):
		node.get_child(0).scored.connect(_on_scored)

func _on_scored(score):
	total_score += score * difficulty
	$Control/Panel/Score.text = str(total_score)
	$Control/ProgressBar.value += 1
		
	if $Control/ProgressBar.value == $Control/ProgressBar.max_value:
		var spawner = boss_enemies.pick_random().instantiate()
		spawner.get_node("Path/PathFollow/Area").scored_boss.connect(_on_scored_boss)
		spawner.position = Vector2(80, 40)
		
		$Level.call_deferred("add_child",spawner)
		bosses += 1
		
func _on_scored_boss(score):
	bosses -= 1
	total_score += score * difficulty
	$Control/Panel/Score.text = str(total_score)
	if bosses < 1:
		level += 1
		$Control/ProgressBar.value = 0
		$EnemyTimer.wait_time = 1.5 - (0.1 * level) - (0.2 * difficulty)
	if level > 5:
		level = 1
		difficulty += 1
		$Level/BackGround.texture = load("res://assets/bg/bg"+str(difficulty%3)+".png")
