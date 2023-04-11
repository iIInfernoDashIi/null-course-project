extends CharacterBody2D


@export var speed: int = 600
@export var start_hp: int = 3
@export var immunity_frames: int = 60
@onready var hp := start_hp

signal damaged(hp: int)


func _ready():
	$ImmunityTimer.wait_time = immunity_frames/60.0
	$Animation.play("none")


func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_pressed("slow"):
		velocity *= 0.5
		
	
	if (velocity.x < 0): $Sprite.frame = 0
	elif (velocity.x > 0): $Sprite.frame = 2
	else: $Sprite.frame = 1
		
	move_and_collide(velocity * speed * delta)
	position = Vector2(clamp(position.x, 0, 640), clamp(position.y, 96, 896))


func take_damage():
	if $ImmunityTimer.is_stopped():
		hp -= 1
		damaged.emit(hp)
		if (hp == 0):
			queue_free()
			$ImmunityTimer.start()
		$Animation.play("blink")


func _on_immunity_timer_timeout():
	$Animation.play("none")
