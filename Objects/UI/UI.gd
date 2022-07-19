extends Control

#var pauser = preload("res://Objects/UI/Pause.tscn") #debating putting this in the ui instead.
#var intro = preload("res://Objects/UI/LevelIntro.tscn")
onready var Pmeter = $PhaseMeter01/Fill
onready var Ptimer = $PTimer
onready var Pause = $PauseRect
onready var SFX_Pause = $SFX_Pause
var PhaseReady = false
var uipause = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pmeter.margin_right = 0
	Ptimer.start()
	Pause.hide()
	#var introin = intro.instance()
	#get_parent().add_child(introin)	
	
func _physics_process(delta: float) -> void:
	Pmeter.margin_right = Ptimer.wait_time
	#print("timer: ",Ptimer.wait_time) #Ptimer should only be active during unpause.
		#pause
	if Input.is_action_just_released("ui_pause"):
		if uipause == false:
			Pause.show()
			print("paused")
			SFX_Pause.play()
			uipause = true
			
			get_tree().paused = true
		else:
			Pause.hide()
			print("unpaused")
			uipause = false
			get_tree().paused = false
