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
var accel = 200

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

func _ready() -> void:
	if dir == -1:
		sprite.flip_h()
	

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
	var statue = DogStatue.instance()
	get_parent().add_child(statue)
	statue.position = self.global_position
	queue_free()


func _on_Hurtbox_body_entered(body: Node) -> void:
	#player colldes with this other.die
	print("connected to doggo")


func _on_TopBouncer_body_entered(body: Node) -> void:
	spd = 0 # Replace with function body. stun it for a second.
	print("boing")
	#set_collision_layer_bit(5,false)
	

func set_behavior(new_state):
	print("%s changing state to %s" % [name, new_state])
	# TODO? Confirm valid state transition?
	# TODO? Put signals here?
	state = new_state

				
func _do_wander_behavior(delta):
	#wanders slowly back and forth.
	anim_player.play("Idle")
	# TODO: Accelerate and clamp
	# TODO: Turn around at edges
	if (_ground_raycast.is_colliding()):
		_set_velocity(WANDER_SPEED * forward_vector)
	else:
		_set_velocity(-WANDER_SPEED * forward_vector)


func _do_seek_behavior(delta):
	#if spots cat (via raycast), will chase it.
	anim_player.play("Run")
	if (_ground_raycast.is_colliding()):
		_set_velocity(SEEK_SPEED * forward_vector)
	else:
		_set_velocity(Vector2.ZERO)
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
	return _player_raycast.is_colliding()


func _should_stop_seek() -> bool:
	# TODO: Replace with cooldown when player is out of sight or unreachable
	return _player_raycast.is_colliding()
