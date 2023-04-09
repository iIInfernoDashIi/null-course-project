extends Node2D

@export_group("spawner")
@export var speed: int = 125
@export var spawnDelay: float = 1.0
@export var spawnRate: float = 0.001
@export var currentRotaion: int = 0
@export var rotationSpeed: int = 8

@export_group("bullet")
@export var packed_scene: PackedScene
@export var bulletSpeed: int = 250
@export var count: int = 10

@onready var velocity: Vector2 = Vector2(0,1)

func _ready():
	$Spawner.wait_time = spawnRate
	if (spawnDelay == 0):
		$Spawner.start()
	else:
		$Delay.wait_time = spawnDelay
		$Delay.start()

func _process(delta):
	position += velocity.rotated(rotation) * speed * delta
	if (position.y > 1000):
		queue_free()

func _on_delay_timeout():
	$Spawner.start()


func _on_spawner_timeout():
	var bullet = packed_scene.instantiate()
	bullet.position = position
	bullet.rotation_degrees += currentRotaion
	bullet.speed = bulletSpeed
	add_sibling(bullet)
	count -=1
	if (count == 0): $Spawner.stop()
	currentRotaion += rotationSpeed
