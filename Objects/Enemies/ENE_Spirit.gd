extends KinematicBody2D
#Spirit
#floats around scanning area
#chases player when in view. Charges towards direction oc cat until aits at its former location.
#can move through walls, but can't see though walls.
#turns into bubble when in dark world. Bubble just floats harmlessly. Maybe.
var vel = Vector2.ZERO
var accel = 400
var topspeed = 400
var AIR_RES = .20

onready var anim_player = $AnimationPlayer
onready var growl = $MonGrowl

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
