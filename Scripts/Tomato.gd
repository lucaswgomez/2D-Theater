extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var picked = false

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.playing = true
    var tomato_types = $AnimatedSprite.frames.get_animation_names()
    $AnimatedSprite.animation = tomato_types[randi() % tomato_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
func _physics_process(delta):
    if picked == true:
        self.position = get_node("../Player/Position2D").global_position

func _input(event):
    if Input.is_action_just_pressed("pick"):
        var areas = $Area2D.get_overlapping_areas()
        for area in areas:
            if area.name == "Player" and get_node("../Player").can_pick == true:
                picked = true
                get_node("../Player").can_pick = false
                
    if Input.is_action_just_pressed("drop") and picked == true:
        picked = false
        get_node("../Player").can_pick = true
        if get_node("../Player/AnimatedSprite").flip_h == false:
            apply_impulse(Vector2(), Vector2(90, -10))
        else:
            apply_impulse(Vector2(), Vector2(-90,-10))
            
    if Input.is_action_just_pressed("throw") and picked == true:
        picked = false
        picked = false
        get_node("../Player").can_pick = true
        if get_node("../Player/AnimatedSprite").flip_h == false:
            apply_impulse(Vector2(), Vector2(150, -200))
        else:
            apply_impulse(Vector2(), Vector2(-150,-200))


func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
