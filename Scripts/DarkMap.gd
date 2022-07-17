extends TileMap

var phase

func _ready() -> void:
	phase = GlobalVars.phase

func _physics_process(delta: float) -> void:
	if phase == true:
		#I forget is true dark orl light?
		self.visible = true
		print(GlobalVars.phase, " darkmap" )
	else:
		self.visible = false

