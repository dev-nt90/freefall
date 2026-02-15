extends CanvasLayer

@onready var stats_panel: Panel = $StatsContainer/StatsContainerPanel/StatsPanel
var game_over_music = preload("res://audio/The_Endless_Journey.mp3")

var final_stats: Dictionary = {}

func _ready() -> void:
    self.visible = false
    $ColorRect.visible = false
    $StatsContainer.visible = false

func handle_entered_endzone(stats: Dictionary) -> void:
    self.final_stats = stats
    AudioManager.play_gameplay_music(game_over_music)
    fade_to_black()

func handle_game_over(stats: Dictionary) -> void:
    self.final_stats = stats
    AudioManager.play_gameplay_music(game_over_music)
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
    var reason_score = 10000 if game_over_reason == 'Made Planetfall' else 0
    $StatsContainer/StatsContainerPanel/StatsPanel/GameOverReasonLabel.text = game_over_reason
    
    var distance_travelled = final_stats['distance_travelled']
    $StatsContainer/StatsContainerPanel/StatsPanel/DistanceTravelledLabel.text = 'Distance Travelled = %d' % distance_travelled
    
    var current_health = final_stats['current_health']
    var health_score = current_health * 500
    $StatsContainer/StatsContainerPanel/StatsPanel/CurrentHealthLabel.text = 'Current Health = %d' % current_health
    
    var current_score = final_stats['current_score']
    $StatsContainer/StatsContainerPanel/StatsPanel/CurrentScoreLabel.text = 'Current Score = %d' % current_score
    
    var final_score = current_score + health_score + reason_score
    $StatsContainer/StatsContainerPanel/StatsPanel/FinalScoreLabel.text = "Final Score = %d" % final_score

func _on_restart_button_pressed() -> void:
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_return_to_menu_button_pressed() -> void:
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
    
