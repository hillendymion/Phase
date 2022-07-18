extends Control
#error Script einherets from native type 'Control', so it cant be instnance in object of type Noe2D
#its being dunb. Will have to find another way.
onready var audio = $Control/Astream

func _ready() -> void:
	get_tree().paused = true
	audio.play()

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		get_tree().paused = false
		queue_free()
