extends Node3D

signal tunnel_chunk_spawned

@onready var tunnel_chunk = preload("res://scenes/tunnel_chunk.tscn")
@onready var asteroid = preload("res://scenes/asteroid.tscn")
@onready var asteroid2 = preload("res://scenes/asteroid_2.tscn")
@onready var asteroid_belt = preload("res://scenes/asteroid_belt.tscn")
@onready var asteroid_belt2 = preload("res://scenes/asteroid_belt_2.tscn")
@onready var comet = preload("res://scenes/comet.tscn")
@onready var ring = preload("res://scenes/ring.tscn")
@onready var satelite = preload("res://scenes/satelite.tscn")
@onready var planet_scene = preload("res://scenes/planet.tscn")
@onready var hud = get_tree().get_first_node_in_group('hud')

@onready var env_objects: Array = [
    asteroid, 
    asteroid2, 
    asteroid_belt, 
    asteroid_belt2, 
    #ring, 
    satelite, 
    comet
]
@onready var active_chunks = $ActiveChunks

var tunnel_rotation_direction: float = 1.0
var tunnel_rotation_speed: float = 0.5
var tail_chunk_y_pos: float = 0

func _ready() -> void:
    spawn_planet()
    spawn_chunk_chain()

func spawn_planet() -> void:
    var planet = planet_scene.instantiate()
    planet.position.y = -10000
    $ActiveChunks.add_child(planet)

func spawn_chunk_chain() -> void:
    for i in range(50):
        tail_chunk_y_pos -= 10
        spawn_chunk()

func spawn_chunk() -> void:
    var new_chunk = tunnel_chunk.instantiate()
    var new_chunk_pos = Vector3(randf_range(-100, 00), tail_chunk_y_pos, randf_range(-100, 100))
    #new_chunk.position.y = tail_chunk_y_pos
    #new_chunk.position.x = randf_range(0, 50)
    #new_chunk.position.z = randf_range(0, 50)
    new_chunk.position = new_chunk_pos
    new_chunk.chunk_freed.connect(spawn_chunk)
    new_chunk.rotation_speed = tunnel_rotation_speed
    new_chunk.rotation_direction = tunnel_rotation_direction

    $ActiveChunks.add_child(new_chunk)
    tunnel_rotation_direction *= -1
    tunnel_chunk_spawned.emit()
    spawn_env_objects(new_chunk)

func spawn_env_objects(chunk_to_orbit) -> void:
    for i in range(3):
        spawn_env_object(chunk_to_orbit)
    
func spawn_env_object(chunk_to_orbit) -> void:
    # TODO: the coment doesn't make sense here so for now just don't pick it
    var random_index = randi_range(0, env_objects.size() - 3)
    #print(random_index)
    var random_object = env_objects[random_index]
    var polarity_modifier = randi_range(0, 1)
    var base_pos = chunk_to_orbit.position
    var rand_x = base_pos.x + (randf_range(20, 50) * (1 if polarity_modifier == 1 else -1))
    var rand_y = base_pos.y
    var rand_z = base_pos.z + (randf_range(20, 50) * (1 if polarity_modifier == 1 else -1))
    var new_object = random_object.instantiate()
    new_object.position = Vector3(rand_x, rand_y, rand_z)
    chunk_to_orbit.add_child(new_object)
