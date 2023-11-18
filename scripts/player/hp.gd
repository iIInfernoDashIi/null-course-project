extends Node2D

@export var speed: int = 75


func _process(delta):
	position += Vector2(0,1).rotated(rotation) * speed * delta

func _on_life_time_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.heal()
		queue_free()
