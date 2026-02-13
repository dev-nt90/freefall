extends Node3D

@onready var player = get_tree().get_first_node_in_group('player')
@onready var planet = get_tree().get_first_node_in_group('planet')
@onready var last_distance_to_planet: int = get_distance_to_planet()
@onready var initial_distance_to_planet: int = last_distance_to_planet
var distance_travelled: int = 0

func _ready() -> void:
    planet.player_entered_endzone.connect(game_over)
    player.player_took_damage.connect(take_damage)
    player.player_died.connect(game_over)

func _process(_delta: float) -> void:
    var current_distance_to_planet: int = get_distance_to_planet()
    
    if last_distance_to_planet != current_distance_to_planet:
        player.backpack_container.update_backpack_distance(current_distance_to_planet)
        distance_travelled = initial_distance_to_planet - current_distance_to_planet
        last_distance_to_planet = current_distance_to_planet
        if distance_travelled % 200 == 0:
            GameConfiguration.set_speed_modifier(GameConfiguration.speed_modifier + .1)
            player.backpack_container.update_backpack_gravity(GameConfiguration.speed_modifier)
    
func take_damage(health: int) -> void:
    print(health)
    
func get_distance_to_planet() -> int:
    if not planet:
        return GameConfiguration.planet_start_y
    if not player:
        return 0
    return abs(int(player.position.y - planet.position.y))

func game_over() -> void:
    get_tree().quit.call_deferred()
