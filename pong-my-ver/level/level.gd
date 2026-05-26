extends Node2D

var score_right: int = 0
var score_left: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ball.scored.connect(_on_score)
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
	pass
