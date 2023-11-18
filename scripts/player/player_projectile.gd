extends Node2D

@export var speed = 175


func _process(delta):
	position += Vector2(0,-1).rotated(rotation) * speed * delta


func _on_life_time_timeout():
	queue_free()


func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage()
		queue_free()
