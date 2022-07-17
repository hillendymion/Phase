extends KinematicBody2D
#floats // moves in fixed positions.

onready var hurtbox = $Hurtbox



func _on_Hurtbox_body_entered(body: Node) -> void:
	#collision with cat #hurts/kills cat.
	print("ow")
	if body == Plyr_Cat:
		body.die()
