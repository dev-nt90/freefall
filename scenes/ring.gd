extends Node3D

signal player_entered_ring

@export var move_speed: float = 10.0
@export var points: int = 100
@onready var mesh_instance = $RingMesh
@onready var yellow_ring_material = preload("res://gfx/materials/ring_yellow.tres")
@onready var white_ring_material = preload("res://gfx/materials/ring_white.tres")
@onready var hud = get_tree().get_first_node_in_group('hud')

func _ready() -> void:
    pass

func set_ring_color(color: String):
    match color:
        "yellow":
            mesh_instance.set_surface_override_material(0, yellow_ring_material)
        "white":
            mesh_instance.set_surface_override_material(0, white_ring_material)
        _:
            print('unknown ring color selected')
    
func _physics_process(delta: float) -> void:
    position.y += move_speed * delta
    

func _on_area_3d_body_entered(body: Node3D) -> void:
    if not body.is_in_group('player'):
        return
    
    # TODO: play sound fx
    player_entered_ring.emit(points)
    hud.update_score(points)
    print('freeing from main ring script')
    self.queue_free.call_deferred()
