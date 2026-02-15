extends Node3D

var gameplay_music = preload("res://audio/Operator Loop.ogg")

func _ready() -> void:
    AudioManager.play_gameplay_music(gameplay_music)
