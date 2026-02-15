extends Node

enum MusicState { NONE, MENU, GAMEPLAY }

@export var fade_time: float = 0.75

var current_music_state: MusicState = MusicState.NONE

var current_stream: AudioStreamPlayer

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    current_stream = AudioStreamPlayer.new()
    add_child(current_stream)
    
    current_stream.bus = 'Music'
    
    current_stream.volume_db = -80.0
    
func play_menu_music(stream: AudioStream) -> void:
    set_music(MusicState.MENU, stream)
    
func play_gameplay_music(stream: AudioStream) -> void:
    set_music(MusicState.GAMEPLAY, stream)
    
func stop_music() -> void:
    if current_music_state == MusicState.NONE:
        return
    
    current_music_state = MusicState.NONE
    xfade_to(null) # fade out and stop
    
func set_music(music_state: MusicState, stream: AudioStream) -> void:
    # If we're already in this state and the same stream is already active, do nothing.
    if current_music_state == music_state and \
        current_stream.stream == stream and \
        current_stream.playing:
        return
    
    current_music_state = music_state
    xfade_to(stream)
        
func xfade_to(new_stream: AudioStream) -> void:
    # do not stack tweens
    for child in find_children("*", "Tween"):
        child.kill()
        
    var tween = create_tween()
    if current_stream and current_stream.playing:
        tween.tween_property(current_stream, "volume_db", -80.0, fade_time)
    
    # if set to null then stop current
    if not new_stream:
        tween.tween_callback(func(): 
            current_stream.stop()
        )
        return
    
    current_stream.stop()
    current_stream.stream = new_stream
    current_stream.volume_db = -80
    current_stream.play()
    
    tween.parallel().tween_property(current_stream, "volume_db", 0.0, fade_time)
