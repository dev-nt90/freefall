class_name Hazard

extends Node3D

@onready var first_child = get_child(0)

func _ready() -> void:
    first_child.use_collision = true
