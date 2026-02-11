extends Node3D

signal chunk_freed

@export var move_speed: float = 10.0
@export var rotation_direction: float
@export var rotation_speed: float

@onready var inner_ring = $TunnelGeometryBase/TunnelInnerRing
@onready var spike_hazard = preload("res://scenes/spike_hazard.tscn")
@onready var score_ring = $Ring

func _ready() -> void:
    create_hazard()
    setup_score_ring()

func _physics_process(delta: float) -> void:
    position.y += move_speed * delta
    rotation.y += rotation_direction * rotation_speed * delta
    if position.y >= 50:
        chunk_freed.emit()
        queue_free.call_deferred()

func setup_score_ring() -> void:
    #score_ring.player_entered_ring.connect(_on_ring_player_entered_ring)
    score_ring.scale = Vector3(.4, .4, .4)
    score_ring.set_ring_color('white')

func create_hazard() -> void:
    var new_hazard = spike_hazard.instantiate()
    new_hazard.position.x = inner_ring.radius
    new_hazard.rotate_z(90)
    new_hazard.scale.x = 3
    new_hazard.scale.y = 3
    new_hazard.scale.z = 3
    
    inner_ring.add_child(new_hazard)
