extends Area2D

@onready var game_manager = %GameManager;
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D

var isActiveOnScreen: bool = false;

func _process(_delta):
	if !isActiveOnScreen:
		animated_sprite_2d.stop();
		return
	animated_sprite_2d.play();

##  SIGNAL
func _on_body_entered(_body):
	game_manager.add_point();
	animation_player.play("pickup");

func _on_visible_on_screen_notifier_2d_screen_entered():
	isActiveOnScreen = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	isActiveOnScreen = false
