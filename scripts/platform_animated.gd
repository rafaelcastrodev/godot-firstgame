extends AnimatableBody2D

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
const SPEED = 60;
var direction = 1;

func _process(delta):
	if(ray_cast_right.is_colliding()):
			direction = -1;
	if(ray_cast_left.is_colliding()):
		direction = 1;
		
	position.x += direction * SPEED * delta;
