extends Area2D

var speed = 175


func _process(delta):
	position += Vector2(0,-1).rotated(rotation) * speed * delta


func _on_life_time_timeout():
	queue_free()


func _on_area_entered(area):
	if ("Asteroid" in area.name):
		area.hp -= 1
		if (area.hp == 0): 
			area.by_shoot = true
			area.destroy()
		queue_free()
