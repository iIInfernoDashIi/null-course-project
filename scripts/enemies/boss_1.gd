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
	var offset_y = randi_range(-100,-60)
	for i in range(6):
		var projectile = projectile_scene.instantiate()
		projectile.get_node("Area").speed = projectile_speed
		if randi_range(0,1) == 0:
			projectile.get_node("Area").position = Vector2(-8 - (24 * i), offset_y + (16 * i))
		else:
			projectile.get_node("Area").position = Vector2(168 + (24 * i), offset_y + (16 * i))
			projectile.get_node("Area").flip = true
#		projectile.rotation_degrees = i * 90 + 45
		get_tree().root.get_node("Game/Level").call_deferred("add_child", projectile)
