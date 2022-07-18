extends KinematicBody2D
#Spirit
#floats around scanning area
#chases player when in view. Charges towards direction oc cat until aits at its former location.
#can move through walls, but can't see though walls.
#turns into bubble when in dark world. Bubble just floats harmlessly. Maybe.
var vel = Vector2.ZERO
var accel = 400
export var spd = 80
export var spdmod = 1
#var AIR_RES = .20
var plyr = null
#onready var _player_raycasts = [
#	$PlayerDetectorLeft, $PlayerDetectorRight, $PlayerDetectorCenter]
onready var anim_player = $AnimationPlayer
onready var growl = $MonGrowl
onready var stalker = $Stalker
onready var charge = $charger
func _ready() -> void:
	anim_player.play("Open")


func _physics_process(delta: float) -> void:
	vel = Vector2(0,0)
	if plyr != null:
		vel = position.direction_to(plyr.position) * spd * spdmod
	else:
		vel = Vector2(0,0)
	vel = vel.normalized()
	vel = move_and_collide(vel)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_Stalker_body_entered(body: Node) -> void:
		#if player gets in range.
	if body != self:
		plyr = body #body is whatever the stalker detects.
		anim_player.play("HoverD")



func _on_Stalker_body_exited(body: Node) -> void:
		#player out of range.
	plyr = null
	anim_player.play("Close")
	spdmod = 1

func _on_Charge_body_entered(body: Node) -> void:
	anim_player.play("Charge")
	spdmod = 2


func _on_Charge_body_exited(body: Node) -> void:
	anim_player.play("HoverD")
	spdmod = 1
