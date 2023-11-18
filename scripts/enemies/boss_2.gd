extends Node2D

signal scored_boss(score: int)

@export var score: int = 7500
@export var speed: int = 50
@export var start_hp: int = 50

@onready var hp := start_hp

@export_group("projectile", "projectile_")
@export var projectile_scene: PackedScene
@export var projectile_speed: int = 55

func _ready():
	$Sprite/Animation.play("appear")

func _process(delta):
	if $Sprite/Animation.is_playing(): return
	$"..".progress += speed * delta

func _on_life_time_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.damage()

func damage():
	hp -= 1
	if (hp == 0): destroy()

func destroy():
	scored_boss.emit(score)
	queue_free()


func _on_spawner_timer_timeout():
	var projectile = projectile_scene.instantiate()
	projectile.get_node("Area").speed = projectile_speed
	projectile.get_node("Area").position = Vector2(randi_range(-4,164), -4)

	get_tree().root.get_node("Game/Level").call_deferred("add_child", projectile)
