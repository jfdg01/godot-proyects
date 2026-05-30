@tool
extends Area2D

@export var size := Vector2(32, 32):
	set(v):
		size = v
		_sync()

func _ready() -> void:
	shape().shape = RectangleShape2D.new()
	_sync()
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("bird")):
		print("Touched the pipe")

func _sync() -> void:
	if not _nodes_ready():
		return
	shape().position.y += (size.y - patch().size.y)/2
	(shape().shape as RectangleShape2D).size = size
	patch().size = size
	

func shape() -> CollisionShape2D:
	return get_node_or_null("CollisionShape2D") as CollisionShape2D

func patch() -> NinePatchRect:
	return get_node_or_null("NinePatchRect") as NinePatchRect

func _nodes_ready() -> bool:
	return shape() != null and patch() != null
