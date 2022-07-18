extends KinematicBody2D
#floats // moves in fixed positions.

onready var _player_raycasts = [
	$PlayerDetectorLeft, $PlayerDetectorRight, $PlayerDetectorCenter]
onready var hurtbox = $Hurtbox
onready var _initial_position = global_position
var _last_patrol_position = null
var _last_player_detection = null
var _patrolling_forward = true

# TODO: Really should put this all in a Finite State Machine
export var FLY_HORIZONTAL = true
# Distance to fly before turning around - always starts by flying right or up
export var PATROL_DISTANCE = 50.0
export var PATROL_SPEED = 200.0
export var ATTACK_SPEED = 150.0
export var ATTACK_ACCEL = 100.0
export var RESET_SPEED = 75.0
export var RESET_ACCEL = 50.0

onready var _target = _get_next_patrol_target()
var _velocity_last_frame = Vector2.ZERO
onready var _target_speed = PATROL_SPEED
var _acceleration_limit = 0.0
# Computed right before each move is executed so we can check next frame 
# and see if we got closer
onready var _target_distance = _initial_position.distance_to(_target)

enum {
	PATROL,
	ATTACK,
	RESET
}

var _behavior_state = PATROL

func _physics_process(delta):
	var new_state = _update_behavior_state()
	if (new_state != _behavior_state):
		_transition_to(new_state)
	if (_behavior_state == PATROL && _target_close()):
		_patrolling_forward = !_patrolling_forward
		_target = _get_next_patrol_target()
	var acceleration = _compute_acceleration(delta)
	_velocity_last_frame += acceleration * delta
	_target_distance = global_position.distance_to(_target)
	move_and_collide(_velocity_last_frame * delta)

func _on_Hurtbox_body_entered(body: Node) -> void:
	#collision with cat #hurts/kills cat.
	print("ow")
	if body == Plyr_Cat:
		body.die() #doesn't quite work.

func _update_behavior_state() -> int:
	match _behavior_state:
		PATROL:
			if (_player_detected()):
				return ATTACK
		ATTACK:
			if (_target_passed()):
				return RESET
		RESET:
			if (_target_close()):
				return PATROL
	return _behavior_state
				

func _transition_to(behavior_state):
	_behavior_state = behavior_state
	match behavior_state:
		RESET:
			_target = _last_patrol_position
			_target_speed = RESET_SPEED
			_acceleration_limit = RESET_ACCEL
		ATTACK:
			_last_patrol_position = _target
			_target = _last_player_detection
			_target_speed = ATTACK_SPEED
			_acceleration_limit = ATTACK_ACCEL
		PATROL:
			_target = _get_next_patrol_target()
			_target_speed = PATROL_SPEED
			_acceleration_limit = 0.0
	print("%s changing state to %s - moving to %s" % [name, behavior_state, _target])
	


func _compute_acceleration(delta: float) -> Vector2:
	var velocity_needed = (_target - global_position).normalized() * _target_speed
	var velocity_change = (velocity_needed - _velocity_last_frame)
	var acceleration = velocity_change / delta
	if (_acceleration_limit == 0.0):
		return acceleration
	var magnitude = acceleration.length()
	var scalar = 1 if magnitude == 0 else clamp(_acceleration_limit / acceleration.length(), 0.0, 1.0)
	return scalar * acceleration
	#var magnitude = accel_needed.length()
	# Allow instantaneous acceleration if no maximum is defined, otherwise
	# clamp it and scale it down
	#var accel_scalar = 1 if _acceleration_limit == 0 else 0 if magnitude == 0 else clamp(
	#	magnitude, -_acceleration_limit, _acceleration_limit) / magnitude
	#return accel_needed * accel_scalar


func _get_next_patrol_target() -> Vector2:
	print("%s finished patrol to %s" % [name, _target])
	if (_patrolling_forward):
		if (FLY_HORIZONTAL):
			return _initial_position + Vector2.RIGHT * PATROL_DISTANCE
		else:
			return _initial_position + Vector2.UP * PATROL_DISTANCE
	return _initial_position


func _target_passed() -> bool:
	# We know we've gotten as close as we can get without oscillating once we
	# start moving away from the target
	return global_position.distance_to(_target) > _target_distance
		

func _target_close() -> bool:
	return _target_distance < 5.0


func _player_detected() -> bool:
	for raycast in _player_raycasts:
		if (raycast.player_detected()):
			_last_player_detection = raycast.player_position()
			return true
	return false
