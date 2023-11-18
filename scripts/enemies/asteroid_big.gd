extends Node2D

signal scored(score: int)

@export var score: int = 2500
@export var speed: int = 55
@export var start_hp: int = 5

@onready var hp := start_hp

@export_group("projectile", "projectile_")
@export var projectile_scene: PackedScene
@export var projectile_score: int = 50
@export var projectile_speed: int = 65

func _process(delta):
	position += Vector2(0,1).rotated(rotation) * speed * delta

func _on_life_time_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.damage()
		destroy()

func damage():
	hp -= 1
	if (hp == 0): destroy(true)

func destroy(by_player: bool = false):
	for i in range(4):
		var projectile = projectile_scene.instantiate()
		projectile.get_node("Area").score = projectile_score
		projectile.get_node("Area").speed = projectile_speed
		projectile.get_node("Area").position = position
		projectile.get_node("Area").rotation_degrees = i * 90 + 45
		get_tree().root.get_node("Game/Level").call_deferred("add_child", projectile)
	if (by_player == true):
		scored.emit(score)
		if (randi() % 100 < 15):
			var hp_drop = load("res://scenes/player/hp.tscn").instantiate()
			hp_drop.position = position
			get_tree().root.get_node("Game/Level").call_deferred("add_child", hp_drop)
	queue_free()
