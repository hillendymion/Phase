extends Node2D

onready var collider = $Area2D/Collider
onready var anim = $AnimatedSprite

func _ready() -> void:
	anim.play()
