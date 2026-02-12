extends LevelPiece

signal player_entered_ring

@export var points: int = 100
@onready var mesh_instance = $RingMesh
@onready var black_ring_material = preload("res://gfx/materials/ring_black.tres")
@onready var yellow_ring_material = preload("res://gfx/materials/ring_yellow.tres")
@onready var blue_ring_material = preload("res://gfx/materials/ring_blue.tres")
@onready var green_ring_material = preload("res://gfx/materials/ring_green.tres")
@onready var red_ring_material = preload("res://gfx/materials/ring_red.tres")
@onready var pink_ring_material = preload("res://gfx/materials/ring_pink.tres")
@onready var white_ring_material = preload("res://gfx/materials/ring_white.tres")
@onready var hud = get_tree().get_first_node_in_group('hud')
var current_material

func _ready() -> void:
    pass
    
func _physics_process(delta: float) -> void:
    position.y += move_speed * delta * GameConfiguration.speed_modifier
    
    if position.y >= 50:
        queue_free.call_deferred()

func set_ring_color(color: String):
    match color:
        "black":
            current_material = black_ring_material.duplicate()
        "yellow":
            current_material = yellow_ring_material.duplicate()
        "blue":
            current_material = blue_ring_material.duplicate()
        "green":
            current_material = green_ring_material.duplicate()
        "red":
            current_material = red_ring_material.duplicate()
        "pink":
            current_material = pink_ring_material.duplicate()
        "white":
            current_material = white_ring_material.duplicate()
        _:
            print('unknown ring color selected')
    mesh_instance.set_surface_override_material(0, current_material)
    
func fade_in():
    var tween = create_tween()
    tween.tween_property(current_material, "albedo_color:a", 0, 0.01)
    tween.tween_property(current_material, "albedo_color:a", .5, 1)
    
    pulse()
    
func pulse():
    var tween = create_tween()
    tween.set_loops()
    tween.tween_property(current_material, "albedo_color:a", 0.05, 1 + randf_range(0, 1))
    tween.tween_property(current_material, "albedo_color:a", .5, 1 + randf_range(0, 1))

func _on_area_3d_body_entered(body: Node3D) -> void:
    if not body.is_in_group('player'):
        return
    
    # TODO: play sound fx
    player_entered_ring.emit(points)
    hud.update_score(points)
    self.queue_free.call_deferred()
