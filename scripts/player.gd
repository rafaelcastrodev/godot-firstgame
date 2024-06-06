extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var sfx_jump = $SfxJump
@onready var coyote_timer = $CoyoteTimer

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const COYOTE_FRAMES: int = 6;
var isOnCoyoteTime: bool = false;
var isLastFrameOnFloor: bool = false;
var isJumping: bool = false;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	coyote_timer.wait_time = COYOTE_FRAMES / 60;

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or isOnCoyoteTime):
		velocity.y = JUMP_VELOCITY
		sfx_jump.play()
		isJumping = true;
	
	# Get input direction (No movement = 0 | Left = -1 | Right = 1)
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false;
	elif direction < 0:
		animated_sprite.flip_h = true;
		
	#Play animations
	if is_on_floor():
		isJumping = false;
		if direction == 0:
			animated_sprite.play("idle");
		else:
			animated_sprite.play("run");
	else:
		animated_sprite.play("jump");
	
	if !is_on_floor() and isLastFrameOnFloor and !isJumping:
		isOnCoyoteTime = true
		coyote_timer.start()

	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

#Animate the character
	isLastFrameOnFloor = is_on_floor()
	move_and_slide()

func _on_coyote_timer_timeout():
	isOnCoyoteTime = false

