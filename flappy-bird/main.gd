extends Node2D

const PipeScene = preload("res://pipe/pipe.tscn")
var screen_w

func _ready() -> void:
	Events.touched_something.connect(_on_touched_floor)
	screen_w = get_viewport_rect().size.x

func _on_touched_floor(message: String) -> void:
	print(message)
	spawn_pipe()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn"):
		spawn_pipe()
	
func spawn_pipe():
	var pipe = PipeScene.instantiate()
	var area = pipe.get_node("Area2D/CollisionShape2D")
	print(area.shape.size)
	pipe.position = Vector2(screen_w + area.shape.size.y ,500)
	add_child(pipe)
	
