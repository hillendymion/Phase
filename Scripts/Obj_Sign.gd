extends StaticBody2D


onready var label = $ColorRect/Label
onready var box = $ColorRect
export var text = "[SPACE]: Jump  [C]: Run"



func _on_Area2D_body_entered(body: Node) -> void:
	label.text = text
	box.visible = true


func _on_Area2D_body_exited(body: Node) -> void:
	box.visible = false
	
