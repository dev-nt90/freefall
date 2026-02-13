extends CanvasLayer

@onready var score_label = $ScoreLabel

var score: int = 0

func _ready() -> void:
    set_score_label()

func update_score(value: int) -> void:
    score += value
    set_score_label()

func set_score_label() -> void:
    score_label.text = "Score: " + str(score)
