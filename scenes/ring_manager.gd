extends Node3D

@onready var ring_scene = preload("res://scenes/ring.tscn")
@onready var collectible_container = get_tree().current_scene.find_child('Collectibles')

func _ready() -> void:
    spawn_rings(20)

func spawn_rings(num: int) -> void:
    for i in range(num):
        spawn_ring()

func spawn_ring():
    var new_ring = ring_scene.instantiate()
    collectible_container.add_child(new_ring)
    
    #TODO: create level bounds object
    var rand_x = randi_range(-100, 100)
    var rand_z = randi_range(-100, 100)
    var rand_y = randi_range(-50, -100)
    var rand_pos = Vector3(rand_x, rand_y, rand_z)
    new_ring.position = rand_pos
    new_ring.set_ring_color('yellow')
