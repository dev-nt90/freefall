extends MeshInstance3D


func _ready():
    fade_in()

func fade_in():
    var tween = create_tween()
    var target_scale = scale
    scale = Vector3(.1,.1,.1)
    tween.tween_property(self, "scale", target_scale, 1.5)
