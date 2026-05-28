extends Node2D

func _ready() -> void:
	Events.touched_something.connect(_on_touched_floor)

func _on_touched_floor(message: String) -> void:
	print(message)
