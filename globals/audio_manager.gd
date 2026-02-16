extends Node

enum MusicState { NONE, MENU, GAMEPLAY }

@export var fade_time: float = 0.25

var current_music_state: MusicState = MusicState.NONE

var current_music_stream_player: AudioStreamPlayer
var fx_stream_player: AudioStreamPlayer

var preduck_db: float

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    setup_music_player()
    setup_fx_player()

func setup_music_player() -> void:
    current_music_stream_player = AudioStreamPlayer.new()
    add_child(current_music_stream_player)
    
    current_music_stream_player.bus = 'Music'
    current_music_stream_player.volume_db = -80.0

func setup_fx_player() -> void:
    fx_stream_player = AudioStreamPlayer.new()
    add_child(fx_stream_player)
    fx_stream_player.autoplay = false
    fx_stream_player.bus = 'SoundFx'
    
func duck_music() -> void:
    preduck_db = current_music_stream_player.volume_db
    current_music_stream_player.volume_db -= 15
    
func unduck_music() -> void:
    current_music_stream_player.volume_db = preduck_db
    
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
        current_music_stream_player.stream == stream and \
        current_music_stream_player.playing:
        return
    
    current_music_state = music_state
    xfade_to(stream)
        
func xfade_to(new_stream: AudioStream) -> void:
    # do not stack tweens
    for child in find_children("*", "Tween"):
        child.kill()
        
    var tween = create_tween()
    if current_music_stream_player and current_music_stream_player.playing:
        tween.tween_property(current_music_stream_player, "volume_db", -80.0, fade_time)
    
    # if set to null then stop current
    if not new_stream:
        tween.tween_callback(func(): 
            current_music_stream_player.stop()
        )
        return
    
    current_music_stream_player.stop()
    current_music_stream_player.stream = new_stream
    current_music_stream_player.volume_db = -80
    current_music_stream_player.play()
    
    tween.parallel().tween_property(current_music_stream_player, "volume_db", 0.0, fade_time)

func play_fx(fx_stream: AudioStream) -> void:
    fx_stream_player.stream = fx_stream
    fx_stream_player.play()
    
