extends CharacterBody2D

@export var ball: Ball

const SPEED = 500.0
var direction: int = 1

func _ready():
	add_to_group("paddles")

func _process(delta: float) -> void:
	if ball.position.y > position.y:
		direction = 1
	if ball.position.y < position.y:
		direction = -1

func _physics_process(delta: float) -> void:
	velocity.y = lerp(velocity.y, direction * SPEED, 10 * delta)
	move_and_slide()
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
