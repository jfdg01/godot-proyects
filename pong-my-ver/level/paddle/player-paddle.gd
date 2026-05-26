extends CharacterBody2D

const SPEED = 500.0

func _ready():
	add_to_group("paddles")

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move-up","move-down")
	velocity.y = direction * SPEED
	move_and_slide()
