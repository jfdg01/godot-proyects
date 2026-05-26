# FILE: Level/Level.gd
extends Node2D

var score_p1 = 0
var score_p2 = 0

# Get references to our other nodes so we can use them in code.
@export var ball: CharacterBody2D
@export var label_p1: Label
@export var label_p2: Label

# This function runs when the level starts.
func _ready():
	assert(ball != null, "ball must be assigned in the Inspector")
	assert(label_p1 != null, "label_p1 must be assigned in the Inspector")
	assert(label_p2 != null, "label_p2 must be assigned in the Inspector")
	
	# This is the magic! We tell the Level to listen for the ball's alarm.
	ball.out_of_bounds.connect(_on_ball_out_of_bounds)
	
	# Start a fresh game
	new_game()

func new_game():
	score_p1 = 0
	score_p2 = 0
	update_score_display()
	ball.start()

# A simple function to keep the text on screen updated.
func update_score_display():
	label_p1.text = "Left: " + str(score_p1)
	label_p2.text = "Right: " + str(score_p2)
	
# This function runs automatically whenever the ball emits its "out_of_bounds" signal.
func _on_ball_out_of_bounds():
	# Check where the ball was when it went out
	if ball.position.x < get_viewport_rect().size.x / 2:
		# It was on the left side, so player 2 scores
		score_p2 += 1
	else:
		# It was on the right side, so player 1 scores
		score_p1 += 1
	
	update_score_display()
