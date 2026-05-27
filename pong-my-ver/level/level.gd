extends Node2D

@export var ball_scene: PackedScene

var score_right: int = 0
var score_left: int = 0

func generate_color():
	var x = randf()
	var y = randf()
	var z = randf()
	var w = randf_range(0.1,1.0)
	return Color(x,y,z,w)

func spawn_ball() -> void:
	for i in 10:
		var ball: Ball = ball_scene.instantiate()
		ball.scale = ball.scale * 0.5
		ball.modulate = generate_color()
		add_child(ball)

func _ready() -> void:
	assert(ball_scene != null, "ball_scene must be assinged in Editor view of Level")
	# $Ball.scored.connect(_on_score)
	$Ui/Right.text = "Right: 0"
	$Ui/Left.text = "Left: 0"

func _on_score(who):
	if who == "right":
		score_right += 1
		$Ui/Right.text = "Right: " + str(score_right)
	if who == "left":
		score_left += 1
		$Ui/Left.text = "Left: " + str(score_left)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn-ball"):
		spawn_ball()
