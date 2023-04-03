extends Node2D

@export var spawnRate: float = 0.1
@export var spawnDelay: float = 1.0
@export var spawnRotation: float = 10.0
var currentRotaion = 0
var packed_scene = PackedScene.new()

func _ready():
	$Spawner.wait_time = spawnRate
	if (spawnDelay == 0):
		$Spawner.start()
	else:
		$Delay.wait_time = spawnDelay
		$Delay.start()
	packed_scene.pack($Bullet)
	$Bullet.queue_free()

func _on_delay_timeout():
	$Spawner.start()


func _on_spawner_timeout():
	var bullet = packed_scene.instantiate()
	bullet.rotation_degrees += currentRotaion
	currentRotaion += spawnRotation
	add_child(bullet)
