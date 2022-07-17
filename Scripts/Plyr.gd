extends KinematicBody2D

#These stats make more sense in here for now.
var ACCEL = 400
var WALK_SPD = 150
var RUN_SPD = 240
var FRICTION = 450
var vel = Vector2.ZERO
#movement here
onready var sprite = $Psprite



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#AnimationTree.active = true #activate when this is ready.
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#copied from other project. not quite working yet
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if inputVector != Vector2.ZERO:
		vel = vel.move_toward(inputVector*WALK_SPD, ACCEL*delta)
	else:
		#AnimationPlayer.play("Idle_Down")
		#AnimationState.travel("Idles")
		vel = vel.move_toward(Vector2.ZERO, FRICTION*delta)
	#move(delta)


func _on_winGame_body_entered(body: Node) -> void:
	#petting animation, fade to white. credits.
	pass # Replace with function body.
