extends CharacterBody2D

@export var speed: int = 35
@onready var animations = $AnimationPlayer 

func updateAnimation():
	if velocity.length() == 0 && animations.is_playing():
		animations.stop()
		return

func collisionHandle():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)
	
func _physics_process(_delta):
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	var direction = "Down"
	if moveDirection.x < 0: direction = "Left"
	elif moveDirection.x > 0: direction = "Right"
	elif moveDirection.y < 0: direction = "Up"
	
	animations.play("walk" + direction)
	
	velocity = moveDirection * speed
	move_and_slide()
	updateAnimation()
