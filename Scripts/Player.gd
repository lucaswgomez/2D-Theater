extends Area2D
signal hit

# Declare member variables here.
export var speed = 400 # Player Speed
var screen_size # Size of game window
var canPick = true


# Called when the node enters the scene tree for the first time.
func _ready():
    hide()
    screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

    var velocity = Vector2.ZERO # The player's movement vector.
    if Input.is_action_pressed("move_right"):
        velocity.x += 1
    if Input.is_action_pressed("move_left"):
        velocity.x -= 1
    if Input.is_action_pressed("move_down"):
        velocity.y += 1
    if Input.is_action_pressed("move_up"):
        velocity.y -= 1

    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.stop()
    position += velocity * delta
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)
    
    if velocity.x != 0:
        $AnimatedSprite.animation = "walk"
        $AnimatedSprite.flip_v = false
        # See the note below about boolean assignment.
        $AnimatedSprite.flip_h = velocity.x < 0



func _on_Player_body_entered(_body):
    if _body.name == "Mob":
        hide() # Player disappears after being hit.
        emit_signal("hit")
        # Must be deferred as we can't change physics properties on a physics callback.
        $CollisionPolygon2D.set_deferred("disabled", true)

func start(pos):
    position = pos
    show()
    $CollisionPolygon2D.disabled = false
