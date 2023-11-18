extends Node2D

signal scored(score: int)

@export var score: int = 500
@export var speed: int = 75
@export var start_hp: int = 1

@onready var hp := start_hp


func _process(delta):
	position += Vector2(0,1).rotated(rotation) * speed * delta

func _on_life_time_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.damage()
		destroy()

func damage():
	hp -= 1
	if (hp == 0): destroy(true)

func destroy(by_player: bool = false):
	if (by_player == true):
		scored.emit(score)
	queue_free()
