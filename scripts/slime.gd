extends Node2D

@onready var ray_cast_right = $RayCast_RIGHT;
@onready var ray_cast_left = $RayCast_LEFT;
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 60;

var direction = 1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(ray_cast_right.is_colliding()):
			direction = -1;
			animated_sprite = true;
	if(ray_cast_left.is_colliding()):
		direction = 1;
		animated_sprite = false;
	position.x += direction * SPEED * delta;
