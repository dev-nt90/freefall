extends Node3D

func _ready() -> void:
    $CanvasLayer/StartMenuContainer.visible = true
    $CanvasLayer/HowToPlayContainer.visible = false
    $CanvasLayer/StartMenuContainer/StartButton.grab_focus()


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
