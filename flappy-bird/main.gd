extends Node2D

const PipeScene = preload("res://pipe/pipe.tscn")
var screen_w
var screen_h

func _ready() -> void:
	Events.touched_something.connect(_on_touched_floor)
	screen_w = get_viewport_rect().size.x
	screen_h = get_viewport_rect().size.y

func _on_touched_floor(message: String) -> void:
	print(message)
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn"):
		var pos_y = randf_range(0, screen_h)
		var gap = randf_range(100,400)
		spawn_pipe(pos_y,gap)
	
func spawn_pipe(pos_y: float, gap: float):
	var pipe = PipeScene.instantiate()
	pipe.position.x = screen_w + pipe.size
	add_child(pipe)
