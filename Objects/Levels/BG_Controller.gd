extends Control

#export preloaded script.
onready var BG = $BG
onready var CurrentPhase = GlobalVars.phase
onready var BGB_B = $BG/BackL/back_B
onready var BGB_W = $BG/BackL/back_W
onready var BGM_B = $BG/MidL/mid_B
onready var BGM_W = $BG/MidL/mid_W
onready var BGF_B = $BG/FrontL/f_B
onready var BGF_W = $BG/FrontL/f_W
func _on_GlobalVars_change_Phase() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_phase"):
		if CurrentPhase == true:
			phase_Dark()
			CurrentPhase = GlobalVars.phase
		elif CurrentPhase == false:
			phase_Light()		
			CurrentPhase = GlobalVars.phase
		
func phase_Dark() -> void:
	#if existance of BGL exists queue free it.
	BGB_B.visible = true
	BGM_B.visible = true
	BGF_B.visible = true
	BGB_W.visible = false
	BGM_W.visible = false
	BGF_W.visible = false

func phase_Light() -> void:
	BGB_B.visible = false
	BGM_B.visible = false
	BGF_B.visible = false
	BGB_W.visible = true
	BGM_W.visible = true
	BGF_W.visible = true
