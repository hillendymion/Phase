extends Control

var pauser = preload("res://Objects/UI/Pause.tscn") #debating putting this in the ui instead.
var intro = preload("res://Objects/UI/LevelIntro.tscn")
onready var Pmeter = $PhaseMeter01/Fill
onready var Ptimer = $PTimer
var PhaseReady = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pmeter.margin_right = 0
	Ptimer.start()
	var introin = intro.instance()
	get_parent().add_child(introin)
	
	
func _physics_process(delta: float) -> void:
	Pmeter.margin_right = Ptimer.wait_time
	#print("timer: ",Ptimer.wait_time)
		#pause
	if Input.is_action_just_released("ui_pause"):
		#var pause = pauser.instance()
		#get_parent().add_child(pauser)
		pass
		
