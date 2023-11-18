extends CharacterBody2D

signal hp_changed(hp: int)
signal destroyed()

@export var speed: int = 600
@export var start_hp: int = 3

@onready var hp := start_hp

@onready var projectile_scene = preload("res://scenes/player/player_projectile.tscn")


func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_pressed("slow"):
		velocity *= 0.5
	
	if (velocity.x < 0): $Sprite.frame = 0
	elif (velocity.x > 0): $Sprite.frame = 2
	else: $Sprite.frame = 1
	
	move_and_collide(velocity * speed * delta)
	position = Vector2(clamp(position.x, 0, 160), clamp(position.y, 24, 220))
		
	if Input.is_action_just_pressed("shoot"):
		_on_reload_timer_timeout()
		$ReloadTimer.start()
	if Input.is_action_just_released("shoot"):
		$ReloadTimer.stop()
		
func _on_reload_timer_timeout():
	var projectile = projectile_scene.instantiate()
	projectile.position = Vector2(position.x, position.y - 4)
	add_sibling(projectile)

func _on_immunity_timer_timeout():
	$Sprite/Animation.stop()

func damage():
	if $ImmunityTimer.is_stopped():
		hp -= 1
		hp_changed.emit(hp)
		if (hp == 0): destroy()
		$Sprite/Animation.play("blink")
		$ImmunityTimer.start()

func destroy():
	$/root/Game/Control/PauseButton.process_mode = Node.PROCESS_MODE_DISABLED
	$/root/Game/Control/Overlay.show()
	$/root/Game/Control/Overlay/Panel/Score.text = $/root/Game/Control/Panel/Score.text
	$/root/Game/Control/Overlay/Panel/Nick.grab_focus()
	queue_free()

func heal():
	hp += 1
	if (hp > 5):
		hp = 5
		$/root/Game._on_scored(5000)
	hp_changed.emit(hp)

