extends Node3D

@export var target_object_count: int = 2500

@onready var asteroid = preload("res://scenes/asteroid.tscn")
@onready var asteroid2 = preload("res://scenes/asteroid_2.tscn")
@onready var asteroid_belt = preload("res://scenes/asteroid_belt.tscn")
@onready var asteroid_belt2 = preload("res://scenes/asteroid_belt_2.tscn")
@onready var comet = preload("res://scenes/comet.tscn") # TODO use this somehow
@onready var ring = preload("res://scenes/ring.tscn")
@onready var satelite = preload("res://scenes/satelite.tscn") # TODO use this somehow
@onready var planet_scene = preload("res://scenes/planet.tscn")

@onready var env_objects: Array = [
    asteroid, 
    asteroid2, 
    asteroid_belt, 
    asteroid_belt2
]

func _ready() -> void:
    spawn_planet()
    spawn_env_objects(target_object_count)

func _process(delta: float) -> void:
    var current_object_count = $ActiveObjects.get_child_count()
    if current_object_count < target_object_count:
        spawn_env_objects(target_object_count - current_object_count)

func spawn_planet() -> void:
    var planet = planet_scene.instantiate()
    planet.position.y = -5000
    $ActiveObjects.add_child(planet)
    
func spawn_env_objects(value: int) -> void:
    for i in range(value):
        spawn_env_object()
    
func spawn_env_object() -> void:
    var random_index = randi_range(0, env_objects.size() - 1)
    var random_object = env_objects[random_index]
    var new_object = random_object.instantiate()
    $ActiveObjects.add_child(new_object)
    
    var pos_polarity_modifier = randi_range(0, 1)
    var rand_x = randi_range(-250, 250)
    var rand_y = randi_range(-200, -500)
    var rand_z = randf_range(-250, 250)
    new_object.position = Vector3(rand_x, rand_y, rand_z)
    new_object.move_speed += randf_range(-2.5, 2.5)
