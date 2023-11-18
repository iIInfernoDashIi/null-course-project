extends Node2D


func _ready():
	$Sprite/Animation.play("stretch")


func _on_life_time_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.damage()
		queue_free()
