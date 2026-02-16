class_name Planet

extends Node3D

signal player_entered_endzone

@export var move_speed: float = GameConfiguration.base_object_speed

func _physics_process(delta: float) -> void:
    position.y += delta * move_speed * GameConfiguration.get_speed_modifier()
    
    if position.y >= 0:
        player_entered_endzone.emit()

func _on_area_3d_body_entered(body: Node3D) -> void:
    if not body.is_in_group('player'):
        return
        
    player_entered_endzone.emit()
