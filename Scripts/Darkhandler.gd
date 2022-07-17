extends Node2D
#shows when Light...

var set #may be used in lew of using global vars directly. I hate coupling. 
var normaly = self.position.y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var set = GlobalVars.phase

func _process(delta: float) -> void:
	if GlobalVars.phase == false:
		self.hide()
		self.position.y += 1000 #yeet
		#needs a way to disable it, not just hide it.
	else:
		self.show()
		self.position.y = normaly #yes its janky, but I can't think of another way.
