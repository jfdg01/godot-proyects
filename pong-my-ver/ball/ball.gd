extends CharacterBody2D

signal scored(who)

const SPEED: float = 700.0
var RNG: float = randf()
var screen_w: int
var screen_h: int
var radius: int

func reset():
	var angle: float = randf() * TAU
	position.x = screen_w / 2
	position.y = screen_h / 2
	velocity.x = -SPEED
	velocity.y = randf_range(-0.5, 0.5) * SPEED

func _ready() -> void:
	radius = $CollisionShape2D.shape.radius
	screen_w = get_viewport_rect().size.x
	screen_h = get_viewport_rect().size.y
	reset();

func _process(delta: float) -> void:
	if position.x < 0:
		scored.emit("right")
		reset()
	if position.x > screen_w:
		scored.emit("left")
		reset()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		reset()
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.get_collider().is_in_group("paddles"):
			velocity = velocity.bounce(collision.get_normal())
			velocity *= 1.05
		if collision.get_collider().is_in_group("walls"):
			velocity = velocity.bounce(Vector2(0,1))
