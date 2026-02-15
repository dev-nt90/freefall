extends CanvasLayer

var select_fx = preload("res://audio/fx/activate_1.wav")
var pause_fx = preload("res://audio/fx/laser_gun_2.wav")

func _ready(): 
    self.visible = false

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed('pause'):
        pause()

func pause():
    get_tree().paused = true
    AudioManager.duck_music()
    AudioManager.play_fx(pause_fx)
    self.visible = true
    $Panel/ResumeButton.grab_focus()

func unpause():
    self.visible = false
    AudioManager.unduck_music()
    get_tree().paused = false

func _on_resume_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    unpause()

func _on_restart_button_pressed() -> void:
    unpause()
    AudioManager.play_fx(select_fx)
    get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_return_to_menu_button_pressed() -> void:
    unpause()
    AudioManager.play_fx(select_fx)
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_button_pressed() -> void:
    get_tree().quit()
