extends Node3D

signal player_entered_chunk

@export var move_speed: float = 10.0
@export var rotation_direction: float
@export var rotation_speed: float

@onready var inner_ring = $TunnelGeometryBase/TunnelInnerRing
@onready var spike_hazard = preload("res://scenes/spike_hazard.tscn")

func _ready() -> void:
    var new_hazard = spike_hazard.instantiate()
    new_hazard.position.x = inner_ring.radius
    new_hazard.rotate_z(90)
    new_hazard.scale.x = 3
    new_hazard.scale.y = 3
    new_hazard.scale.z = 3
    inner_ring.add_child(new_hazard)

func _physics_process(delta: float) -> void:
    position.y += move_speed * delta
    rotation.y += rotation_direction * rotation_speed * delta
    if position.y >= 100:
        queue_free.call_deferred()

func _on_area_3d_body_entered(body: Node3D) -> void:
    if body.is_in_group('player'):
        player_entered_chunk.emit()
