extends Control


onready var Pmeter = $PhaseMeter01/Fill
onready var Ptimer = $PTimer
var PhaseReady = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pmeter.margin_right = 0
	Ptimer.start()

func _physics_process(delta: float) -> void:
	Pmeter.margin_right = Ptimer.wait_time
	#print("timer: ",Ptimer.wait_time)
