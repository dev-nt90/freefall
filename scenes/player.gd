extends CharacterBody3D

@export var move_speed: float = 6

func _physics_process(delta: float) -> void:
    move_logic(delta)
    move_and_slide()
    
func move_logic(delta: float) -> void:
    var input_dir = Input.get_vector("right", "left", "down", "up")
    
    if input_dir != Vector2.ZERO:
        position.x += input_dir.x * move_speed * delta
        position.z += input_dir.y * move_speed * delta
