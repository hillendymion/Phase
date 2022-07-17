extends Node2D

#for blinking?
export(PackedScene) var target_scene #scene is world //next level.

onready var pstart = $Control/VSplitContainer/pressStart

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		start_game()
	if Input.is_action_pressed("ui_select"):
		start_game()
	

func start_game():
	var ERR = get_tree().change_scene_to(target_scene)
	#can a specific camera be set to the changed scene?
	if ERR != OK:
		print("someting went wrong here")
