extends Node


@export var default_speed_modifier: float = 1.0

@export var base_object_speed: float = 20.0
@export var speed_modifier: float = 1.0
@export var dive_speed_modifier: float = 2.0
@export var max_horizontal: int = 500
@export var min_horizontal: int = -500
@export var planet_start_y: int = -10000
@export var speed_increase_interval: int = 250
@export var environment_hazards: int = 500
var dive_active: bool = false
var chosen_difficulty: String = 'normal'

func get_speed_modifier() -> float:
    if dive_active:
        return speed_modifier * dive_speed_modifier
    else:
        return speed_modifier
        
func set_speed_modifier(value: float) -> void:
    speed_modifier = value

func reset() -> void:
    dive_active = false
    speed_modifier = default_speed_modifier
    if chosen_difficulty == 'easy':
        apply_easy_configuration()
    elif chosen_difficulty == 'normal':
        apply_normal_configuration()
    elif chosen_difficulty == 'hard':
        apply_hard_configuration()
    elif chosen_difficulty == 'very hard':
        apply_very_hard_configuration()
    else:
        push_error('something went wrong while resetting game configuration')
    
func apply_easy_configuration() -> void:
    planet_start_y = -5000
    base_object_speed = 10.0
    environment_hazards = 250
    chosen_difficulty = 'easy'
    
func apply_normal_configuration() -> void:
    chosen_difficulty = 'normal'
    
func apply_hard_configuration() -> void:
    planet_start_y = -15000
    base_object_speed = 30.0
    environment_hazards = 1000
    speed_modifier = 2.0
    chosen_difficulty = 'hard'
    
func apply_very_hard_configuration() -> void:
    planet_start_y = -25000
    base_object_speed = 50.0
    environment_hazards = 1500
    speed_modifier = 3.0
    chosen_difficulty = 'very hard'
