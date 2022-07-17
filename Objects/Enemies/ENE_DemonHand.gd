extends KinematicBody2D
#Moves up at at a set speed when cat moves close. loweres when cat is away.
#Eversion homage

onready var detector = $Detector
onready var hurtbox = $hurtbox

var startpoint
var mover = false
var vel = Vector2.ZERO
var spd = 200

func _ready() -> void:
	startpoint = self.global_position.y

func _physics_process(delta: float) -> void:
	if mover == true:
		if self.position.y < startpoint+ 128:
			vel.y = spd*delta 
	else:
		if self.position.y > startpoint: #somehow this is invalid.
			vel.y = spd/2*delta
	vel = move_and_slide(vel)

func _on_Detector_body_entered(body: Node) -> void:
	if body == Plyr_Cat:
		mover == true


func _on_Detector_body_exited(body: Node) -> void:
	if body == Plyr_Cat:
		mover == false


func _on_Hurtbox_body_entered(body: Node) -> void:
	#kills the cat
	pass # Replace with function body.
