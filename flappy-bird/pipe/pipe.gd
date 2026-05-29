extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("bird")):
		print("Touched the pipe")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x = position.x - 400 * delta
	pass
