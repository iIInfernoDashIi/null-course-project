extends Area2D


@export var speed: int = 125
@export var lifeTime: float = 10

@onready var velocity: Vector2 = Vector2(0,1)


func _ready():
	$LifeTime.wait_time = lifeTime
	$LifeTime.start()


func _process(delta):
	position += velocity.rotated(rotation) * speed * delta


func _on_Bullet_body_entered(body):
	if body.name == "Player":
		body.take_damage()
		queue_free()


func _on_life_time_timeout():
	queue_free()
