extends Node3D

signal chunk_freed

@onready var inner_ring = $TunnelGeometryBase/TunnelInnerRing
@onready var score_ring = $Ring

@export var rotation_speed: float = 1.0
@export var rotation_direction: float = 1.0
@export var move_speed: float = GameConfiguration.base_object_speed

func _ready() -> void:
    setup_score_ring()

func _physics_process(delta: float) -> void:
    position.y += move_speed * delta * GameConfiguration.get_speed_modifier()
    rotation.y += rotation_speed * rotation_direction * delta
    if position.y >= 50:
        chunk_freed.emit()
        queue_free.call_deferred()

func setup_score_ring() -> void:
    score_ring.scale = Vector3(.4, .4, .4)
    score_ring.set_ring_color('white')
