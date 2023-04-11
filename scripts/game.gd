extends Node


@export var packed_scene: PackedScene


func _ready():
	pass


func _on_enemy_timer_timeout():
	var spawner = packed_scene.instantiate()
	spawner.position = Vector2(randi_range(0,640), 0)
	spawner.currentRotaion = -36
	$Level.add_child(spawner)
