extends Node

# TODO: difficulty selection which changes hazard count, base speed, initial dist to planet, etc
@export var default_speed_modifier: float = 1.0

@export var speed_modifier: float = 1.0
@export var max_horizontal: int = 500
@export var min_horizontal: int = -500
@export var planet_start_y: int = -10000
@export var speed_increase_interval: int = 250
@export var environment_hazards: int = 500

func set_speed_modifier(value: float) -> void:
    speed_modifier = value

func reset() -> void:
    speed_modifier = default_speed_modifier
    
