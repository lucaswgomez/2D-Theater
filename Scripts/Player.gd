extends KinematicBody2D
signal hit

# Declare member variables here.
export var speed = 400 # Player Speed
var screen_size # Size of game window
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	zoom()
	
	#start of movement code
	var movement_x = 0
	var movement_y = 0
	
	if Input.is_action_pressed("ui_left"):
		movement_x -= speed
	if Input.is_action_pressed("ui_right"):
		movement_x += speed
	if Input.is_action_pressed("ui_up"):
		movement_y -= speed
	if Input.is_action_pressed("ui_down"):
		movement_y += speed
	direction = Vector2(movement_x, movement_y).normalized()
	move_and_slide(direction*speed)
	#end of movement code
	if !direction.length() == 0:
		if movement_x > 0:
			$AnimatedSprite.set_flip_h(false)
			$AnimatedSprite.play()
		else:
			$AnimatedSprite.set_flip_h(true)
			$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

func _on_Player_area_entered(_area):
	hide()
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionPolygon2D.set_deferred("disabled", true)


func zoom():

		if Input.is_action_just_released("wheel_down"):
			$Camera2D.zoom.x += 0.25
			$Camera2D.zoom.y += 0.25
		if Input.is_action_just_released("wheel_up") and $Camera2D.zoom.x > 1 and $Camera2D.zoom.y > 1:
			$Camera2D.zoom.x -= 0.25
			$Camera2D.zoom.y -= 0.25


func start(pos):
	position = pos
	show()
	$CollisionPolygon2D.disabled = false
