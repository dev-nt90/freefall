extends Node3D

var menu_music = preload("res://audio/music/01 Falling Organ.mp3")
var select_fx = preload("res://audio/fx/activate_1.wav")

func _ready() -> void:
    show_start()
    hide_instructions()
    hide_diff()
    AudioManager.play_menu_music(menu_music)

#region Start Buttons
    
func _on_start_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    hide_start()
    show_instructions()

func _on_quit_button_pressed() -> void:
    get_tree().quit()

#endregion

#region Inst Buttons
func _on_back_to_start_menu_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    hide_instructions()
    show_start()

func _on_continue_to_diff_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    hide_instructions()
    show_diff()

#endregion

#region Diff Buttons

func _on_easy_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    GameConfiguration.apply_easy_configuration()
    load_game()
    
func _on_normal_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    GameConfiguration.apply_normal_configuration()
    load_game()

func _on_hard_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    GameConfiguration.apply_hard_configuration()
    load_game()

func _on_very_hard_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    GameConfiguration.apply_very_hard_configuration()
    load_game()
    
func _on_back_to_inst_button_pressed() -> void:
    AudioManager.play_fx(select_fx)
    hide_diff()
    show_instructions()
    
#endregion

#region Util

func hide_start() -> void:
    $CanvasLayer/StartMenuContainer.visible = false

func show_start() -> void:
    $CanvasLayer/StartMenuContainer.visible = true
    $CanvasLayer/StartMenuContainer/StartButton.grab_focus()

func hide_instructions() -> void:
    $CanvasLayer/HowToPlayContainer.visible = false
    
func show_instructions() -> void:
    $CanvasLayer/HowToPlayContainer.visible = true
    $CanvasLayer/HowToPlayContainer/Panel/ContinueToDiffButton.grab_focus()
    
func hide_diff() -> void:
    $CanvasLayer/DifficultySelectionContainer.visible = false
    
func show_diff() -> void:
    $CanvasLayer/DifficultySelectionContainer.visible = true
    $CanvasLayer/DifficultySelectionContainer/Panel/NormalButton.grab_focus()
    
func load_game():
    get_tree().change_scene_to_file("res://scenes/game.tscn")

#endregion
