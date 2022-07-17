extends KinematicBody2D


var Doge = load("res://Objects/Enemies/ENE_Doge.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Phaseout():
	var mydoge = Doge.instance()
	get_parent().add_child(mydoge)
	mydoge.position = self.global_position
	queue_free()
