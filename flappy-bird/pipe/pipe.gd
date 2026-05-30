@tool
extends Node2D

@export var gap_center: float = 300.0:
	set(v): gap_center = v; _sync()
@export var gap_size: float = 150.0:
	set(v): gap_size = v; _sync()
@export var pipe_width: float = 128.0:
	set(v): pipe_width = v; _sync()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_sync()

func top() -> Area2D:
	return get_node_or_null("PipeTop") as Area2D

func bottom() -> Area2D:
	return get_node_or_null("PipeBottom") as Area2D
	
func gap() -> Area2D:
	return get_node_or_null("Gap") as Area2D

func _pipes_ready() -> bool:
	return bottom() != null and gap() != null and top() != null

func _sync() -> void:
	if not _pipes_ready():
		return
	print("Ready")
	var screen_h := get_viewport_rect().size.y
	var top_h := gap_center - gap_size / 2.0
	var bot_h := gap_center + gap_size / 2.0
	
	(gap().get_node("CollisionShape2D").shape as RectangleShape2D).size.y = gap_size
	gap().position.y = gap_center
	top().position.y = top_h + top().size.y
	bottom().position.y = bot_h - bottom().size.y
	# top().size.y = 300
	# bottom().size.y = 300

	# _get_bottom().size = Vector2(pipe_width, screen_h - bot_h)
	#_get_bottom().position = Vector2(0.0, gap_center + gap_size / 2.0 + bot_h / 2.0)

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	position.x -= 400 * delta
	pass
