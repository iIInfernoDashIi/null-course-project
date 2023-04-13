extends Node2D

@export var score: int = 2500
@export var speed: int = 55
@export var start_hp: int = 5
@onready var hp := start_hp
var by_shoot = false

@export_group("projectile", "projectile_")
@export var projectile_scene: PackedScene
@export var projectile_speed: int = 65


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(0,1).rotated(rotation) * speed * delta


func _on_life_time_timeout():
	queue_free()
	

func _on_body_entered(body):
	if body.name == "Player":
		body.take_damage(self)


func destroy():
	for i in range(4):
		var projectile = projectile_scene.instantiate()
		projectile.speed = projectile_speed
		projectile.position = position
		projectile.rotation_degrees = i * 90 + 45
		add_sibling(projectile)
	queue_free()
