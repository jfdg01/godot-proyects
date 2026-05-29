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
	spawn_pipe()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn"):
		spawn_pipe()
	
func spawn_pipe():
	var pipe = PipeScene.instantiate()
	var area = pipe.get_node("Area2D/CollisionShape2D")
	var nine_patch = pipe.get_node("NinePatchRect")
	var pipe_y = area.shape.size.y
	var pipe_x = area.shape.size.x
	pipe.position = Vector2(screen_w + pipe_x , randf_range(0,screen_h - pipe_y))
	if pipe.position.y < screen_h / 2:
		# pipe.scale = Vector2(3.0,-3.0) # rotated if above middle line
		pipe.scale = Vector2(3.0,3.0)
	else:
		pipe.scale = Vector2(3.0,3.0) # normal if below middle line
		
	var offset_correction = abs(nine_patch.offset_top) * 2
	nine_patch.size.y = (screen_h - pipe.position.y + offset_correction * pipe.scale.y) / pipe.scale.y
	add_child(pipe)
