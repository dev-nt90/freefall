extends Node3D

@onready var ring_scene = preload("res://scenes/ring.tscn")
@onready var collectible_container = get_tree().current_scene.find_child('Collectibles')
@onready var times = $Timers

func _ready() -> void:
    pass

func spawn_rings(num: int, color: String, points: int) -> void:
    for i in range(num):
        spawn_ring(color, points)

func spawn_ring(color: String, points: int):
    var new_ring = ring_scene.instantiate()
    collectible_container.add_child(new_ring)
    
    
    var rand_x = randi_range(GameConfiguration.min_horizontal, GameConfiguration.max_horizontal)
    var rand_z = randi_range(GameConfiguration.min_horizontal, GameConfiguration.max_horizontal)
    var rand_y = randi_range(-100, -500)
    var rand_pos = Vector3(rand_x, rand_y, rand_z)
    new_ring.position = rand_pos
    new_ring.points = points
    new_ring.set_ring_color(color)
    new_ring.fade_in()

func _on_yellow_ring_timer_timeout() -> void:
    spawn_rings(3, 'yellow', 100)

func _on_blue_ring_timer_timeout() -> void:
    spawn_rings(7, 'blue', 75)

func _on_green_ring_timer_timeout() -> void:
    spawn_rings(12, 'green', 50)

func _on_red_ring_timer_timeout() -> void:
    spawn_rings(18, 'red', 25)

func _on_pink_ring_timer_timeout() -> void:
    spawn_rings(25, 'pink', 5)

func _on_black_ring_timer_timeout() -> void:
    spawn_rings(1, 'black', 1000)
