extends Node2D

var SPEED = 500
@onready var width = $Area2D/CollisionShape2D.shape.size.x/2
		
func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta
	if position.x < 0 - width:
		position.x = get_viewport_rect().size.x + width
		pass
	
func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	$Area
	$NinePatchRect.size.y *= 2

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("bird"):
		Events.touched_something.emit("Touched a pipe")
	
