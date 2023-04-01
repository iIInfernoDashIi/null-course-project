extends CharacterBody2D

@export var speed: int = 600
@export var start_hp: int = 3
@export var immunity_frames: int = 60
@onready var hp := start_hp


func _ready():
	$ImmunityTimer.wait_time = immunity_frames/60.0
	print($ImmunityTimer.wait_time)
	pass


func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_pressed("slow"):
		velocity *= 0.5
	move_and_collide(velocity * speed * delta)


func take_damage():
	if $ImmunityTimer.is_stopped():
		hp -= 1
		if (hp == 0):
			queue_free()
		$AnimationPlayer.play("immune")
		$ImmunityTimer.start()
	


func _on_immunity_timer_timeout():
	$AnimationPlayer.stop()
