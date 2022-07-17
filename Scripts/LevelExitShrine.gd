extends KinematicBody2D

export var toLevel = 2 #or maybe packed scene?
onready var Area2d = $Area2D


#listen for player collission, when collided, go to level indicated.

func _ready() -> void:
	pass # Replace with function body.



func _on_Area2D_body_entered(body: Node) -> void:
	if toLevel == 1:	
		get_tree().change_scene("res://Objects/Levels/Level_01.tscn")
	elif toLevel == 2:
		get_tree().change_scene("res://Objects/Levels/Level_02.tscn")	
	elif toLevel == 3:
		get_tree().change_scene("res://Objects/Levels/Level_03.tscn")	
	elif toLevel == 4:
		get_tree().change_scene("res://Objects/Levels/Level_04.tscn")
	else:
		get_tree().change_scene("res://Objects/Levels/Level_01.tscn")
