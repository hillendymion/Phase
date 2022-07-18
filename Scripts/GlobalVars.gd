extends Node2D

#true == light, false == dark
var phase = true setget changePhase, get_Phase
var GRAVITY = 256
var CurrentLevel = 1 setget set_Level, get_Level
#screw it, this seems like the best way.
var hp = 1 setget hp_change, get_hp

signal change_Phase
signal phase_Dark
signal phase_Light
signal catdie

func changePhase(val):
	#val is the value of 'phase' passed through this thing.
	#this should be the setter?
	phase = val
	if val == true:
		emit_signal("phase_Light")
		emit_signal("change_Phase")
	elif val == false:
		emit_signal("phase_Dark")
		emit_signal("change_Phase")



func get_Phase():
	return phase
	
func set_Level(val):
	CurrentLevel = val	
func get_Level():
	return CurrentLevel

func hp_change(val):
	val = hp
	if hp <= 0:
		emit_signal("catdie")
	
func get_hp():
	return hp
