extends Area2D


@export var speed: int = 100
@export var velocit: Vector2 = Vector2(0,0)
@export var angle: int = 0


func _ready():
	rotation_degrees = angle


func _process(delta):
	var velocity = Vector2 (0, -1).rotated(rotation)
	position += velocity * speed * delta


func _on_Bullet_body_entered(body):
	if body.name == "Player":
		body.take_damage()
		queue_free()
