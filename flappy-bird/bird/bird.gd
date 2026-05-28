extends CharacterBody2D

const JUMP_VELOCITY = -400.0

func _ready() -> void:
	add_to_group("bird")

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		
	if velocity.y < 0:
		rotation_degrees = lerp(rotation_degrees, -30.0, 0.2)
	elif velocity.y > 0:
		rotation_degrees = lerp(rotation_degrees, 30.0, 0.2)
	else:
		rotation_degrees = lerp(rotation_degrees, 0.0, 0.2) # Doesn't ever execute, kept for consistency
	
	move_and_slide()
