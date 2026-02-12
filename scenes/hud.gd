extends CanvasLayer

@onready var distance_label = $DistanceLabel
@onready var score_label = $ScoreLabel
@onready var speed_modifier_label = $SpeedModifierLabel

var score: int = 0

func _ready() -> void:
    set_score_label()
    set_speed_modifier_label(GameConfiguration.speed_modifier)

func update_score(value: int) -> void:
    score += value
    set_score_label()

func set_score_label() -> void:
    score_label.text = "Score: " + str(score)

func set_distance_label(value: int) -> void:
    distance_label.text = "Distance to Planet: " + str(value)
    
func set_speed_modifier_label(value: float) -> void:
    speed_modifier_label.text = "Current Speed Modifier %1f" % value
