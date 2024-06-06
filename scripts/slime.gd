extends Node2D

@onready var ray_cast_right = $RayCast_RIGHT;
@onready var ray_cast_left = $RayCast_LEFT;
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 60;

var direction = 1;
var isActiveOnScreen: bool = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isActiveOnScreen:
		return
		
	if(ray_cast_right.is_colliding()):
			direction = -1;
			animated_sprite = true;
	if(ray_cast_left.is_colliding()):
		direction = 1;
		animated_sprite = false;
	position.x += direction * SPEED * delta;
	
func _on_visible_on_screen_notifier_2d_screen_entered():
	isActiveOnScreen = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	isActiveOnScreen = false
