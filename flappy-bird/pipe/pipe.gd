extends Node2D

var screen_h: float
var gap_size: float = 300
var gap_position: Vector2 = Vector2(400,500)

func start() -> void:
	screen_h = get_viewport_rect().size.y

func _ready() -> void:
	start()
	calculate_pipes(gap_position, gap_size)
	
func calculate_pipes(gap_pos: Vector2, gap_size: float):
	var gap_coll: CollisionShape2D = get_node("Gap/GapCollShape")
	var gap_rect: RectangleShape2D = gap_coll.shape
	gap_coll.position = gap_pos
	gap_rect.size.y = gap_size
	calculate_top(gap_coll.position, gap_rect.size.y)
	calculate_bot(gap_coll.position, gap_rect.size.y)

func calculate_top(gap_pos: Vector2, gap_size: float):
	var top_coll: CollisionShape2D = get_node("Body/TopCollShape")
	var top_rect: RectangleShape2D = top_coll.shape
	var top_h = gap_pos.y - gap_size / 2
	var top_y = top_h / 2
	var top_x = gap_pos.x
	top_coll.position = Vector2(top_x, top_y)
	top_rect.size.y = abs(top_h)
	
func calculate_bot(gap_pos: Vector2, gap_size: float):
	var bot_coll: CollisionShape2D = get_node("Body/BotCollShape")
	var bot_rect: RectangleShape2D = bot_coll.shape
	var bot_h = screen_h - gap_pos.y - (gap_size / 2)
	var bot_y = screen_h - (bot_h / 2)
	var bot_x = gap_pos.x
	bot_coll.position = Vector2(bot_x, bot_y)
	bot_rect.size.y = abs(bot_h)

func _physics_process(delta: float) -> void:
	pass
