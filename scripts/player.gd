extends CharacterBody2D

signal hp_changed(hp: int)

@export var speed: int = 600
@export var immunity_frames: int = 60
@export var start_hp: int = 3

@onready var projectile_scene = preload("res://scenes/player_projectile.tscn")
@onready var hp := start_hp


func _ready():
	$ImmunityTimer.wait_time = immunity_frames/60.0


func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_pressed("slow"):
		velocity *= 0.5
	
	if (velocity.x < 0): $Sprite.frame = 0
	elif (velocity.x > 0): $Sprite.frame = 2
	else: $Sprite.frame = 1
	
	move_and_collide(velocity * speed * delta)
	position = Vector2(clamp(position.x, 0, 160), clamp(position.y, 24, 224))
	
	if Input.is_action_just_pressed("shoot"):
		var projectile = projectile_scene.instantiate()
		projectile.position = Vector2(position.x, position.y - 4)
		add_sibling(projectile)


func damage(projectile: Node2D = null):
	if $ImmunityTimer.is_stopped():
		if projectile != null: projectile.destroy()
		hp -= 1
		hp_changed.emit(hp)
		if (hp == 0): queue_free()
		$ImmunityTimer.start()
		$Sprite/Animation.play("blink")


func heal():
	hp += 1
	if (hp > 5):
		hp = 5
		$"../..".score += 5000
		$"../..".update_score()
	hp_changed.emit(hp)


func _on_immunity_timer_timeout():
	$Sprite/Animation.stop()
