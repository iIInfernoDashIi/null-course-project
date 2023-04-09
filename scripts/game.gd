extends Node

@export var packed_scene: PackedScene
@onready var boundStartX = $LevelBoundaries.position.x
@onready var boundEndX = boundStartX + $LevelBoundaries/CollisionShape.position.x * 2

func _ready():
	pass


func _on_pause_button_pressed():
	get_tree().paused = not(get_tree().paused)


func _on_enemy_timer_timeout():
	var spawner = packed_scene.instantiate()
	spawner.position = Vector2(randi_range(boundStartX,boundEndX), 0)
	spawner.currentRotaion = -36
	add_child(spawner)
