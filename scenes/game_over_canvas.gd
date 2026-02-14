extends CanvasLayer

@onready var stats_panel: Panel = $StatsContainer/StatsContainerPanel/StatsPanel

var final_stats: Dictionary = {}

func _ready() -> void:
    self.visible = false
    $ColorRect.visible = false
    $StatsContainer.visible = false

func handle_entered_endzone(stats: Dictionary) -> void:
    self.final_stats = stats
    fade_to_black()

func handle_game_over(stats: Dictionary) -> void:
    self.final_stats = stats
    fade_to_black()

func fade_to_black() -> void:
    get_tree().paused = true
    self.visible = true
    $ColorRect.visible = true
    
    var tween = create_tween()
    tween.tween_property($ColorRect, "color", Color(0,0,0,1), 1)
    tween.tween_callback(show_stats)

func show_stats() -> void:
    $StatsContainer/StatsContainerPanel/RestartButton.grab_focus()
    $StatsContainer.visible = true
    var game_over_reason = final_stats['game_over_reason']
    $StatsContainer/StatsContainerPanel/StatsPanel/GameOverReasonLabel.text = game_over_reason

func _on_restart_button_pressed() -> void:
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_return_to_menu_button_pressed() -> void:
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
    
