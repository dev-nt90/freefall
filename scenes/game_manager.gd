extends Node3D

@onready var player = get_tree().get_first_node_in_group('player')
@onready var planet = get_tree().get_first_node_in_group('planet')
@onready var game_over_canvas = get_tree().get_first_node_in_group('game_over_canvas')

@onready var last_distance_to_planet: int = get_distance_to_planet()
@onready var initial_distance_to_planet: int = last_distance_to_planet
var distance_travelled: int = 0
var current_score: int = 0
var stats: Dictionary

func _ready() -> void:
    planet.player_entered_endzone.connect(entered_endzone)
    player.player_died.connect(game_over)
    stats = {
        'game_over_reason': 'Unknown',
        'distance_travelled': '0',
        'current_score': '0',
        'current_health': '3',
    }

func _process(_delta: float) -> void:
    var current_distance_to_planet: int = get_distance_to_planet()
    
    if last_distance_to_planet != current_distance_to_planet:
        player.backpack_container.update_backpack_distance(current_distance_to_planet)
        distance_travelled = initial_distance_to_planet - current_distance_to_planet
        last_distance_to_planet = current_distance_to_planet
        if distance_travelled % 200 == 0:
            GameConfiguration.set_speed_modifier(GameConfiguration.speed_modifier + .1)
            player.backpack_container.update_backpack_gravity(GameConfiguration.speed_modifier)

func get_distance_to_planet() -> int:
    if not planet:
        return GameConfiguration.planet_start_y
    if not player:
        return 0
    return abs(int(player.position.y - planet.position.y))

func update_current_score(value: int) -> void:
    current_score += value
    player.update_score(current_score)
    
func entered_endzone() -> void:
    var current_health = player.get_current_health()
    
    stats = {
        'game_over_reason': 'Made Planetfall',
        'distance_travelled': distance_travelled,
        'current_score': current_score,
        'current_health': current_health,
    }
    game_over_canvas.handle_entered_endzone(stats)
    
func game_over() -> void:
    var current_health = player.get_current_health()
    
    stats = {
        'game_over_reason': 'Death',
        'distance_travelled': distance_travelled,
        'current_score': current_score,
        'current_health': current_health,
    }
    game_over_canvas.handle_game_over(stats)
