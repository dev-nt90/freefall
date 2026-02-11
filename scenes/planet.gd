extends Node3D

func _physics_process(delta: float) -> void:
    #scale.x += .1
    #scale.y += .1
    #scale.z += .1
    position.y += 10 * delta
