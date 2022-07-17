extends Node2D

onready var anim_plyr = $AnimationPlayer
onready var SFXdie = $SFX_CatHit
onready var SFXfall = $SFX_CatFall
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get if touching fall or enemy.
	SFXdie.play()
	anim_plyr.play("bubble")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	#not connecting?
	var level = GlobalVars.get_Level()
	print(level)
	if level == 1:
		get_tree().change_scene("res://Objects/Levels/Level_01.tscn")
	elif level == 2:
		get_tree().change_scene("res://Objects/Levels/Level_02.tscn")
	elif level == 3:
		get_tree().change_scene("res://Objects/Levels/Level_03.tscn")
	else:
		get_tree().change_scene("res://Objects/Levels/Level_01.tscn")
