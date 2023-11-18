extends Node2D

var speed: int


func _ready():
	$Sprite/Animation.play("shake")
	
	
func _process(delta):
	position += Vector2(0,1) * speed * delta

func _on_life_time_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.damage()
		queue_free()
