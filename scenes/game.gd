extends Node3D

var gameplay_music = preload("res://audio/music/Operator Loop.ogg")

# TODO: different music for different difficulties
func _ready() -> void:
    GameConfiguration.reset()
    AudioManager.play_gameplay_music(gameplay_music)
    $EnvironmentManager.set_target_object_count()
