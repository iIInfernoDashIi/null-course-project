extends Node


func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not(get_tree().paused)
