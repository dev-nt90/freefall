extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group('player')
@onready var planet = get_tree().get_first_node_in_group('planet')
@onready var distance_label = $DistanceLabel
@onready var score_label = $ScoreLabel
var score: int = 0

func _ready() -> void:
    set_score_label()

func _process(_delta: float) -> void:
    distance_label.text = "Distance to Planet: " + str(abs(int(player.position.y - planet.position.y)))

func update_score(value: int):
    score += value
    set_score_label()

func set_score_label():
    score_label.text = "Score: " + str(score)
