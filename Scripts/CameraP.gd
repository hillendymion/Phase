extends Camera2D

onready var topLeft = $TopLeft
onready var bottomRight = $BottomRight 
#wonder if theres an easing options for camera movements.


func _ready() -> void:
	limit_top = topLeft.global_position.y
	limit_left = topLeft.global_position.x
	limit_bottom = bottomRight.global_position.y
	limit_right = bottomRight.global_position.x
