# FILE: Paddle/Paddle.gd
extends CharacterBody2D

# These variables will show up in the editor
@export var speed: float = 400
@export var up_action = "ui_up"
@export var down_action = "ui_down"
@export var ball: Ball

# This function runs once when the paddle is created.
func _ready():
	# Add this paddle to a group called "paddles". We'll use this later.
	add_to_group("paddles")

func _process(delta: float) -> void:
	var direction: float = 0
	if ball.position.y > position.y:
		direction = 1
	elif ball.position.y < position.y:
		direction = -1

	position.y += direction * speed * delta

	var screen_size = get_viewport_rect().size
	var paddle_height = 32
	position.y = clamp(position.y, paddle_height / 2, screen_size.y - (paddle_height / 2))
