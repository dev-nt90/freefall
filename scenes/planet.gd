class_name Planet

extends LevelPiece

signal player_entered_endzone

func _physics_process(delta: float) -> void:
    super._physics_process(delta)
    
    if position.y >= 0:
        player_entered_endzone.emit()

func _on_area_3d_body_entered(body: Node3D) -> void:
    if not body.is_in_group('player'):
        return
        
    player_entered_endzone.emit()
