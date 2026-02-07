extends Node3D

signal tunnel_chunk_spawned

@onready var tunnel_chunk = preload("res://scenes/tunnel_chunk.tscn")

@onready var active_chunks = $ActiveChunks

var tunnel_rotation_direction: float = 1.0
var tunnel_rotation_speed: float = 0.5
var tail_chunk_y_pos: float = 0

func _ready() -> void:
    spawn_chunk_chain()

func spawn_chunk_chain() -> void:
    for i in range(10):
        tail_chunk_y_pos -= 10
        spawn_chunk()

func spawn_chunk() -> void:
    var new_chunk = tunnel_chunk.instantiate()
    new_chunk.position.y = tail_chunk_y_pos
    new_chunk.player_entered_chunk.connect(_on_tunnel_chunk_player_entered_chunk)
    new_chunk.rotation_speed = tunnel_rotation_speed
    new_chunk.rotation_direction = tunnel_rotation_direction

    $ActiveChunks.add_child(new_chunk)
    tunnel_rotation_direction *= -1
    tunnel_chunk_spawned.emit()

func _on_tunnel_chunk_player_entered_chunk() -> void:
    spawn_chunk()
