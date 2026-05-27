extends CharacterBody2D

class_name Ball

signal scored(who)

const SPEED: float = 700.0
var RNG: float = randf()
var screen_w: int
var screen_h: int
var radius: int

func reset():
	var angle: float = randf() * TAU
	position.x = screen_w / 2 + randf()
	position.y = screen_h / 2 + randf()
	velocity.x = -SPEED if randf() > 0.5 else SPEED
	velocity.y = randf_range(-0.5, 0.5) * SPEED

func _ready() -> void:
	radius = $CollisionShape2D.shape.radius
	screen_w = get_viewport_rect().size.x
	screen_h = get_viewport_rect().size.y
	add_to_group("balls")
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
		var normal = collision.get_normal()
		var collider = collision.get_collider()
		
		if collider.is_in_group("balls"):
			var other_ball = collider as Ball
			var relative_velocity = velocity - other_ball.velocity
			var impulse = relative_velocity.dot(normal)
			if impulse < 0:
				velocity -= impulse * normal
				other_ball.velocity += impulse * normal
		
		else: 
			velocity = velocity.bounce(normal)
			if collider.is_in_group("paddles"):
				velocity *= 1.05
