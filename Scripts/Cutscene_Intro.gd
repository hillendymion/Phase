extends Node2D

onready var cutcene = $AnimationPlayer
export var scene_ch = "res://Objects/Levels/Level_01.tscn"

func _ready() -> void:
	cutcene.play("Cutscene")
#on animation end go to first level.

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_cancel"):
		print("skipped")
		get_tree().change_scene(scene_ch)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	#go to level 1.
	get_tree().change_scene(scene_ch)
