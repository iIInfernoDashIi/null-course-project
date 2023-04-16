extends Area2D

@export var score: int = 500
@export var speed: int = 75
@export var start_hp: int = 1
@onready var hp := start_hp
var by_shoot = false


func _process(delta):
	position += Vector2(0,1).rotated(rotation) * speed * delta


func _on_life_time_timeout():
	queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		body.damage(self)


func destroy():
	queue_free()
