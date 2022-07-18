extends KinematicSpriteBody 
#doge. 
#wanders slowly when idle
#chases player/cat when in view
#turns to stone when in light world

onready var _player_raycast = $PlayerDetector
onready var _ground_raycast = $GroundDetector

var g_direction = Vector2.UP
export var WANDER_SPEED = 80
export var SEEK_SPEED = 160
export var SEEK_COOLDOWN = 3
var accel = 200
var seek_time_remaining = 0

onready var hurtbox = $Hurtbox
onready var anim_player = $AnimationPlayer
#for some reason preload pisses it off.
var DogStatue = load("res://Objects/Enemies/ENE_DogeStatue.tscn")
#give it 2 modes. wander, chase.
#raycast looks for player. chases player when intersected.
var GRAVITY = GlobalVars.GRAVITY

#don't need one for IDLE, thats just in move.
enum {
	WANDER,
	SEEK,
	STONE
}
var state = WANDER
	

func _physics_process(delta: float) -> void:
	var state_after_update = _update_behavior_state()
	if (state_after_update != state):
		set_behavior(state_after_update)

	match state:
		WANDER:
			_do_wander_behavior(delta)
		SEEK:
			_do_seek_behavior(delta)

	move_and_collide(velocity * delta)


func PhaseForm():
	#this isn't loading right. may have to try a new tactic.
	#var statue = DogStatue.instance()
	#get_parent().add_child(statue)
	#statue.position = self.global_position
	#queue_free()
	pass

func _on_Hurtbox_body_entered(body: Node) -> void:
	#player colldes with this other.die
	print("connected to doggo")


func _on_TopBouncer_body_entered(body: Node) -> void:
	 # TODO: Get stunned
	print("boing")
	#set_collision_layer_bit(5,false)
	

func set_behavior(new_state):
	print("%s changing state to %s" % [name, new_state])
	# TODO? Confirm valid state transition?
	# TODO? Put signals here?
	state = new_state

			
func _can_move_forward(direction: Vector2) -> bool:
	return _ground_raycast.is_colliding() && !test_move(transform, direction)


func _do_wander_behavior(delta):
	#wanders slowly back and forth.
	anim_player.play("Idle")
	# TODO: Accelerate and clamp
	# TODO: Turn around at edges
	var move_vector = WANDER_SPEED * forward_vector
	if (_can_move_forward(move_vector * delta)):
		_set_velocity(move_vector)
	else:
		_set_velocity(-move_vector)


func _do_seek_behavior(delta):
	#if spots cat (via raycast), will chase it.
	anim_player.play("Run")
	var move_vector = SEEK_SPEED * forward_vector
	var can_move = _can_move_forward(move_vector * delta)
	if (_player_raycast.player_detected() && can_move):
		seek_time_remaining = SEEK_COOLDOWN
	else:
		seek_time_remaining -= delta
		
	if (can_move):
		_set_velocity(move_vector)
	else:
		_set_velocity(-move_vector)
	# TODO: Accelerate and clamp
	


func _update_behavior_state() -> int:
	match state:
		WANDER:
			if (_should_start_seek()):
				return SEEK
		SEEK:
			if (_should_stop_seek()):
				return WANDER
	return state


func _should_start_seek() -> bool:
	return _player_raycast.player_detected()


func _should_stop_seek() -> bool:
	# TODO: Replace with cooldown when player is out of sight or unreachable
	return seek_time_remaining <= 0
