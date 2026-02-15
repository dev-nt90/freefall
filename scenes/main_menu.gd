extends Node3D

var menu_music = preload("res://audio/01 Falling Organ.mp3")

func _ready() -> void:
    $CanvasLayer/StartMenuContainer.visible = true
    $CanvasLayer/HowToPlayContainer.visible = false
    $CanvasLayer/StartMenuContainer/StartButton.grab_focus()
    AudioManager.play_menu_music(menu_music)


func _on_start_button_pressed() -> void:
    $CanvasLayer/StartMenuContainer.visible = false
    $CanvasLayer/HowToPlayContainer.visible = true
    $CanvasLayer/HowToPlayContainer/Panel/ContinueButton.grab_focus()


func _on_quit_button_pressed() -> void:
    get_tree().quit()

func _on_back_button_pressed() -> void:
    $CanvasLayer/StartMenuContainer.visible = true
    $CanvasLayer/HowToPlayContainer.visible = false
    $CanvasLayer/StartMenuContainer/StartButton.grab_focus()

func _on_continue_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/game.tscn")
