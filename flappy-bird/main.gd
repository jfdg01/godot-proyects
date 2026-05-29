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
	spawn_bottom_pipe(pos_y, gap)
	spawn_top_pipe(pos_y, gap)
	
func spawn_bottom_pipe(pos_y: float, gap: float):
	var pipe = PipeScene.instantiate()
	var area = pipe.get_node("Area2D/CollisionShape2D")
	var nine_patch = pipe.get_node("NinePatchRect")
	var pipe_y = area.shape.size.y
	var pipe_x = area.shape.size.x
	pipe.position = Vector2(screen_w + pipe_x, pos_y + gap)
	nine_patch.size.y = screen_h
	pipe.scale = Vector2(3.0,3.0) # normal if below middle line
	add_child(pipe)
	
func spawn_top_pipe(pos_y: float, gap: float):
	var pipe = PipeScene.instantiate()
	var area = pipe.get_node("Area2D/CollisionShape2D")
	var nine_patch = pipe.get_node("NinePatchRect")
	var pipe_y = area.shape.size.y
	var pipe_x = area.shape.size.x
	pipe.position = Vector2(screen_w - pipe_x, pos_y + gap)
	nine_patch.size.y = screen_h
	pipe.scale = Vector2(3.0,-3.0) # rotated 180 deg
	add_child(pipe)
