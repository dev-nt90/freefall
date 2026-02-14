extends CanvasLayer

func _ready(): 
    self.visible = false

func _process(delta: float) -> void:
    if Input.is_action_just_pressed('pause'):
        pause()

func pause():
    get_tree().paused = true
    self.visible = true
    $Panel/ResumeButton.grab_focus()

func unpause():
    self.visible = false
    get_tree().paused = false

func _on_resume_button_pressed() -> void:
    unpause()

func _on_restart_button_pressed() -> void:
    unpause()
    get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_return_to_menu_button_pressed() -> void:
    unpause()
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_button_pressed() -> void:
    get_tree().quit()
