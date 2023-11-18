extends Node2D

var speed: int
var flip: bool

var direction: Vector2


func _ready():
	if flip:
		$Sprite.flip_h = true
		direction = Vector2(-1,2)
	else:
		direction = Vector2(1,2)
	
	
func _process(delta):
	position += direction * speed * delta

func _on_life_time_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.damage()
		queue_free()
