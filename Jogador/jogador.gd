extends CharacterBody2D

var movement_speed = 80.0

@onready var sprite = $Sprite2D
@onready var walkTimer = $walkTimer

func _physics_process(delta: float) -> void:
	movement()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov,y_mov)
	
	if mov.x > 0:
		sprite.flip_h = true
	elif mov.x < 0:
		sprite.flip_h = false
	
	if mov != Vector2.ZERO: 
		if walkTimer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else: 
				sprite.frame = 1
			walkTimer.start()
	
	
	velocity = mov.normalized()*movement_speed
	move_and_slide()
