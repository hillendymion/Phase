extends KinematicBody2D
#doge. 
#wanders slowly when idle
#chases player/cat when in view
#turns to stone when in light world

var vel = Vector2.ZERO #motion
var g_direction = Vector2.UP
export var dir = 1 # -1 for the ther way.
var spd = 80
var tspeed = 420
var accel = 200

onready var sprite = $Sprite
onready var hurtbox = $Hurtbox
onready var caster = $RayCast2D
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
	vel.y += GRAVITY
	match state:
		WANDER:
			Wander_State(delta)
		SEEK:
			Seek_State(delta) #pause, I guess.
			
func Wander_State(delta):
	#wanders slowly back and forth.
	anim_player.play("Idle")
	
	if vel.x > 0:
		sprite.flip_h
	vel.x = spd*dir
	move(delta)
func Seek_State(delta):
	#if spots cat (via raycast), will chase it.
	if caster.find_node(Plyr_Cat):
		#vel = tspeed
		anim_player.play("Run")
	move(delta)

func move(delta):
	vel = move_and_slide(vel, g_direction)

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
	spd = 0 # Replace with function body. stun it for a second.
	print("boing")
	#set_collision_layer_bit(5,false)
