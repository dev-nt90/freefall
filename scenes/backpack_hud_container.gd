extends MeshInstance3D

@onready var backpack_hud = $BackpackHud

func _ready():
    var viewport_texture = backpack_hud.get_texture()
    var material = StandardMaterial3D.new()
    material.albedo_texture = viewport_texture
    
    var gradient = Gradient.new()
    gradient.set_color(0, Color.BLACK) # Center color
    gradient.set_color(1, Color.BLUE)   # Edge color
    
    var gradient_texture = GradientTexture2D.new()
    gradient_texture.gradient = gradient
    gradient_texture.fill = GradientTexture2D.FILL_RADIAL
    gradient_texture.fill_from = Vector2(0.5, 0.5) # Center of texture
    gradient_texture.fill_to = Vector2(1, 0.5)     # Radius edge
    
    material.emission_enabled = true
    material.emission_texture = gradient_texture
    material.emission_energy_multiplier = .25
    
    self.material_override = material
    
func update_backpack_health(value: int) -> void:
    $BackpackHud/HeartContainer/HeartCountLabel.text = "X %d" % value
    
func update_backpack_distance(value: int) -> void:
    $BackpackHud/DistanceToPlanetLabel.text = "Dist: %d" % value

func update_backpack_gravity(value: float) -> void:
    $BackpackHud/GravityModifierLabel.text = "Grav: %.1f" % value

func update_backpack_score(value: int) -> void:
    $BackpackHud/ScoreLabel.text = "Score: %d" % value
