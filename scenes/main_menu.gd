extends Node3D

var menu_music = preload("res://audio/music/01 Falling Organ.mp3")
var select_fx = preload("res://audio/fx/activate_1.wav")

func _ready() -> void:
    $CanvasLayer/StartMenuContainer.visible = true
    $CanvasLayer/HowToPlayContainer.visible = false
    $CanvasLayer/StartMenuContainer/StartButton.grab_focus()
    AudioManager.play_menu_music(menu_music)


func _on_start_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    $CanvasLayer/StartMenuContainer.visible = false
    $CanvasLayer/HowToPlayContainer.visible = true
    $CanvasLayer/HowToPlayContainer/Panel/ContinueButton.grab_focus()


func _on_quit_button_pressed() -> void:
    get_tree().quit()

func _on_back_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    $CanvasLayer/StartMenuContainer.visible = true
    $CanvasLayer/HowToPlayContainer.visible = false
    $CanvasLayer/StartMenuContainer/StartButton.grab_focus()

func _on_continue_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    get_tree().change_scene_to_file("res://scenes/game.tscn")
