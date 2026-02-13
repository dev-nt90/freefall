class_name LevelPiece

extends Node3D

@export var move_speed: float = 10.0
@export var base_rotation_speed: float = 1.0
@export var rotation_modifier: float = randf_range(.5, 1.5)
var rotate_x: bool = true if randi_range(0, 1) == 1 else false
var rotate_y: bool = true if randi_range(0, 1) == 1 else false
var rotate_z: bool = true if randi_range(0, 1) == 1 else false

func _physics_process(delta: float) -> void:
    position.y += delta * move_speed * GameConfiguration.speed_modifier
    handle_rotation(delta)
    if position.y >= 50:
        queue_free.call_deferred()

func handle_rotation(delta: float) -> void:
    if rotate_x:
        rotation.x += base_rotation_speed * rotation_modifier * delta
    if rotate_y:
        rotation.y += base_rotation_speed * rotation_modifier * delta
    if rotate_z:
        rotation.z += base_rotation_speed * rotation_modifier * delta
