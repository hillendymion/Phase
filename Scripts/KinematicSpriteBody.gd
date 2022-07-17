class_name KinematicSpriteBody
extends KinematicBody2D

onready var _sprite = $Sprite
onready var _initially_flipped = _sprite.flip_h
onready var _ground_detector = $GroundDetector
onready var _initial_ground_detector_x = _ground_detector.position.x

onready var forward_vector = Vector2.RIGHT
var velocity = Vector2.ZERO setget _set_velocity

func _set_velocity(v: Vector2):
	velocity = v
	if (is_zero_approx(v.x)):
		return

	if (sign(v.x) != sign(forward_vector.x)):
		if (v.x > 0):
			forward_vector = Vector2.RIGHT
			_sprite.flip_h = _initially_flipped
			_ground_detector.position.x = _initial_ground_detector_x
		elif (v.x < 0):
			forward_vector = Vector2.LEFT
			_sprite.flip_h = !_initially_flipped
			_ground_detector.position.x = -_initial_ground_detector_x

func get_node(path) -> Node:
	return .get_node(path)
