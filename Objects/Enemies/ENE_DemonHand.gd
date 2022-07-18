extends KinematicBody2D
#Moves up at at a set speed when cat moves close. loweres when cat is away.
#Eversion homage

onready var rawr = $Rawr
onready var detector = $Detector
onready var hurtbox = $hurtbox
export var upshift = 82 # the height it rises to.
export var spd = 500
var startpoint
var rawrcheck = 0
var mover = false
var vel = Vector2.ZERO


func _ready() -> void:
	startpoint = self.global_position.y

func _physics_process(delta: float) -> void:
	if mover == true:
		if self.position.y < startpoint+ upshift:
			vel.y = -spd
		elif self.position.y >= startpoint+upshift:
			self.position.y = startpoint+upshift
			vel = Vector2.ZERO
	else:
		if self.position.y > startpoint: #somehow this is invalid.
			vel.y = spd* 0.2 #go down slowish
		elif self.position.y <= startpoint:
			vel = Vector2.ZERO
	vel = move_and_slide(vel)#giving me an error.

func _on_Detector_body_entered(body: Node) -> void:
	#if body == Plyr_Cat:
	mover = true
	print("I see you")
	
	if rawrcheck == 0:
		rawr.play()
		rawrcheck = 1


func _on_Detector_body_exited(body: Node) -> void:
	#if body == Plyr_Cat:
	print("shiggity")
	mover = false
	rawrcheck = 0


func _on_Hurtbox_body_entered(body: Node) -> void:
	#kills the cat
	pass # Replace with function body.
