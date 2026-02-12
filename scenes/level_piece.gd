class_name LevelPiece

extends Node3D

@export var move_speed: float = 10.0
@export var rotation_speed: float = 1.0
@export var rotation_direction: float = 1.0
var amplitude: float = 50.0  # How high/low the object moves
var frequency: float = 2.0   # How fast the object moves up and down
var time_elapsed: float = 0.0

func setup() -> void:
    pass

func _physics_process(delta: float) -> void:
    #var offset = sin(time_elapsed * frequency) * amplitude
    #position.x += delta * offset * move_speed
    position.y += delta * move_speed * GameConfiguration.speed_modifier
    #position.z += delta * offset * move_speed
    
    if position.y >= 50:
        queue_free.call_deferred()
