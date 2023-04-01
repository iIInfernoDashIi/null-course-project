extends Node2D


func _ready():
	pass


func _process(delta):
	pass


func _on_pause_button_pressed():
	get_tree().paused = not(get_tree().paused)
