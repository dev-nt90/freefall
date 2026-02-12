extends CharacterBody3D

signal player_took_damage
signal player_died

@export var max_speed: float = 10.0
@export var accel: float = 35.0
@export var decel: float = 0.5
@export var rotation_speed: float = 1.5
@export var move_speed: float = 6

var vel: Vector3 = Vector3.ZERO

@export var max_lean_degrees: float = 12.0
@export var lean_in_time: float = 0.08
@export var lean_out_time: float = 0.14
var _lean_tween: Tween

@export var health: int = 3
var can_take_damage: bool = true

@onready var info_label: Label3D = $InfoLabel
@onready var thruster_smoke_fx = $Effects/ThrusterSmoke
@onready var visual_root = $VisualRoot

func _ready() -> void:
    info_label.text = ""
    thruster_smoke_fx.emitting = false

func _physics_process(delta: float) -> void:
    move_logic(delta)
    move_and_slide()
    
func move_logic(delta: float) -> void:
    var input_dir = Input.get_vector("right", "left", "down", "up")
    
    # since objects can collide with the player and move them up, this keeps them
    # locked in place vertically to keep the illusion
    position.y = 0
    
    # core movement, make player feel "floaty"
    move_by_velocity(delta, input_dir)
    handle_rotation(delta)
    apply_lean(input_dir.x)

func move_by_velocity(delta: float, input_dir: Vector2):
    # get local axes in WORLD space
    var right = global_transform.basis.x
    var forward = -global_transform.basis.z  # Godot forward is -Z

    # flatten so rotation around Y doesn't introduce vertical drift
    right.y = 0
    forward.y = 0

    right = right.normalized()
    forward = forward.normalized()
    
    # combine input with rotated axes
    var desired_dir = (right * input_dir.x) + (forward * input_dir.y)
    
    if desired_dir.length_squared() > 0.0001:
        thruster_smoke_fx.emitting = true
        vel += desired_dir * accel * delta
        
        # Clamp max speed
        var speed := vel.length()
        if speed > (max_speed * GameConfiguration.speed_modifier):
            vel = vel / speed * (max_speed * GameConfiguration.speed_modifier)
    else:
        thruster_smoke_fx.emitting = false
         
        # No input: brake toward zero
        var speed := vel.length()
        if speed > 0.0:
            var drop := decel * delta
            vel = vel * max(0.0, (speed - drop) / speed)
    
    # Move by velocity
    position += vel * delta

func handle_rotation(delta: float):
    if Input.is_action_pressed("rotate_left"):
        rotation.y += rotation_speed * delta
    if Input.is_action_pressed("rotate_right"):
        rotation.y -= rotation_speed * delta

func apply_lean(horizontal: float) -> void:
    # Target roll: right input -> lean right
    var target_roll_rad = deg_to_rad(max_lean_degrees) * -horizontal

    # If we’re already basically there, don’t spam tweens
    if is_equal_approx(visual_root.rotation.z, target_roll_rad):
        return

    # Kill previous tween so rapid direction changes feel snappy
    if _lean_tween and _lean_tween.is_running():
        _lean_tween.kill()

    var duration = lean_out_time if horizontal == 0.0 else lean_in_time

    _lean_tween = create_tween()
    _lean_tween.set_trans(Tween.TRANS_SINE)
    _lean_tween.set_ease(Tween.EASE_OUT)
    _lean_tween.tween_property(visual_root, "rotation:z", target_roll_rad, duration)


func _on_area_3d_area_entered(area: Area3D) -> void:
    print(area.get_groups())
    if not area.is_in_group('collectible'):
        take_damage()

func _on_area_3d_body_entered(body: Node3D) -> void:
    print(body.get_groups())
    if not body.is_in_group('collectible'):
        take_damage()
        
func take_damage() -> void:
    # TODO: bug here, collectibles are causing damage to be taken
    if can_take_damage:
        can_take_damage = false
        health -= 1
        if health <= 0:
            player_died.emit()
        else:
            player_took_damage.emit(health)
            $Timers/PlayerDamageTimer.start()


func _on_player_damage_timer_timeout() -> void:
    can_take_damage = true
