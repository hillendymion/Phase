extends Node2D
#script attached to level. camera is child of player.
#does plyer cat need to be onready?
onready var cam = $CameraP

const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 955
const LIMIT_BOTTOM = 690

func _ready():
	randomize()
	GlobalVars.CurrentLevel = 1
	#set camera to camera P if available.
	cam.make_current()
