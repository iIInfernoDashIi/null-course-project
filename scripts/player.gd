extends CharacterBody2D

@export var speed: int = 600
@export var start_hp: int = 3
@export var immunity_frames: int = 60
@onready var hp := start_hp

@onready var boundStartX = $"../LevelBoundaries".position.x
@onready var boundEndX = boundStartX + $"../LevelBoundaries/CollisionShape".position.x * 2
@onready var boundStartY = $"../LevelBoundaries".position.y
@onready var boundEndY = boundStartY + $"../LevelBoundaries/CollisionShape".position.y * 2


func _ready():
	$ImmunityTimer.wait_time = immunity_frames/60.0
	
	$AnimationPlayer.play("none")
	$BulletCollision/AnimationCollision.play("hitbox_rotate")


func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down").normalized()
	
	$BulletCollision/CollisionSprite.hide()
	if Input.is_action_pressed("slow"):
		velocity *= 0.5
		$BulletCollision/CollisionSprite.show()
		
	move_and_collide(velocity * speed * delta)
	position = Vector2(clamp(position.x, boundStartX, boundEndX), clamp(position.y, boundStartY, boundEndY))


func take_damage():
	if $ImmunityTimer.is_stopped():
		print("!!!")
		hp -= 1
		if (hp == 0):
			queue_free()
		$AnimationPlayer.play("blink")
		$ImmunityTimer.start()
	


func _on_immunity_timer_timeout():
	$AnimationPlayer.play("none")
