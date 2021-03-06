extends KinematicBody2D
class_name Plyr_Cat
#extends Actor

#move vars
var ACCEL = 520
var WALK_SPD = 140
var RUN_SPD = 240
var FRICTION = .50
var AIR_RES = .20
export var JUMPFORCE = 146
var vel = Vector2.ZERO #motion
var running = false
var g_direction = Vector2.UP

var GRAVITY = GlobalVars.GRAVITY #for now

const FLOOR_DETECT_DISTANCE = 20.0
export(String) var action_suffix = ""

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
onready var Hurtbox = $Hurtbox
onready var sound_jump = $SFX_Jump
onready var Ptimer = $Ptimer
onready var jumpBuffer = $Jumpbuffer
onready var coyoteTime = $CoyoteTime
#sfx
onready var SFXJump = $SFX_Jump
onready var SFXPhaseBlack = $SFX_Phase_Black
onready var SFXPhaseWhite = $SFX_Phase_White
#onready var gun = sprite.get_node(@"Gun")

var catdie = preload("res://Objects/CatDie.tscn")

#don't need one for IDLE, thats just in move.
enum {
	MOVE,
	MENU,
	SPELL
}
var state = MOVE

func _ready() -> void:
	sprite.frame = 9


func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			Move_State(delta)
		MENU:
			Menu_State(delta) #pause, I guess.
		SPELL:
			pass #for now

func Move_State(delta):

	
	#movement here
	var x_Input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")


	if x_Input != 0:
		#rollVector = inputVector
		#figure out howt to declare animation state.
		sprite.flip_h =  x_Input > 0
		if is_on_floor():
			if running == true:
				#vel = vel.move_toward(inputVector*RUN_SPD, ACCEL*delta)
				anim_player.play("RunL") #may need a new walk cycle.
				vel.x = x_Input * ACCEL * RUN_SPD * delta
				vel.x = clamp(vel.x, -RUN_SPD, RUN_SPD)
				#print("running spd: ",vel.x)
			else:
				anim_player.play("WalkL") #may need a new walk cycle.
				vel.x = x_Input * ACCEL * WALK_SPD * delta
				vel.x = clamp(vel.x, -WALK_SPD, WALK_SPD) #locks top speed.
				#print("walking spd: ",vel.x)
		else:
			vel.x = x_Input * ACCEL/2 * WALK_SPD * AIR_RES* delta
	# If no movement input but still in air, don't change the animation yet
	elif (is_on_floor()):
		anim_player.play("StopL")
	#	AnimationState.travel("Idles")

	#gravity.
	vel.y += GRAVITY*delta 
		
	#jumping
	if Input.is_action_just_pressed("ui_jump"):
		jumpBuffer.start()
		
	if is_on_floor(): 
		coyoteTime.start()
		if !jumpBuffer.is_stopped():
			jump()
		if Input.is_action_pressed("ui_run"):
			running = true
		if Input.is_action_just_released("ui_run"):
			running = false
		if x_Input == 0:
			vel.x = lerp(vel.x, 0, FRICTION) #same as line above.
	else:
		#in the air
		if coyoteTime.is_stopped():
			pass#vel.y += GRAVITY*delta #not quite sure about this here.
		elif !jumpBuffer.is_stopped():
			jump()
		if Input.is_action_just_released("ui_jump") and vel.y < -JUMPFORCE/2:
			vel.y = -JUMPFORCE/2
			anim_player.play("JumpL")
			#better jump control.
			print("jump")
		elif x_Input == 0:
			vel.x = lerp(vel.x, 0, AIR_RES)
			#anim_player.play("FallL")
		elif x_Input !=0 and vel.y > 0:
			vel.x = lerp(vel.x, 0, AIR_RES)
			anim_player.play("FallL")
	move(delta)
	#phase command.
	if Input.is_action_just_released("ui_phase"):
		#change phase global variable.
		if GlobalVars.phase == false:
			print("SpiritWorld")
			SFXPhaseWhite.play()
			GlobalVars.phase = true #not wanting to change.
		elif GlobalVars.phase == true:
			print("NightWorld")
			GlobalVars.phase = false
			SFXPhaseBlack.play()

			
	#reset level
	if Input.is_action_just_released("ui_end"):
		pass
		
func move(delta):
	vel = move_and_slide(vel, g_direction) 
	#second parameter tells it which way is up. This looks like an easy way to reverse gravity.	
func Menu_State(delta):
	#For Pause screen and/or RPG menu.
	set_process(false)
	#will hve to set up a listener.


func _on_DeathPit_body_entered(body: Node) -> void:
	if body == self:
		print("moobs")
		die()

func _on_Spikes_body_entered(body: Node) -> void:
	if body == self:
		print("spiked")
		die()

func jump():
	vel.y = -JUMPFORCE
	jumpBuffer.stop()
	SFXJump.play()
	anim_player.play("JumpL")
	coyoteTime.stop()


func die():
		#not connecting?
	var die = catdie.instance()
	get_parent().add_child(die)
	die.position = self.global_position
	queue_free()
	#var level = GlobalVars.get_Level()
	#print(level)
	#if level == 1:
	#	get_tree().change_scene("res://Objects/Levels/Level_01.tscn")
	#elif level == 2:
	#	get_tree().change_scene("res://Objects/Levels/Level_02.tscn")
	#elif level == 3:
	#	get_tree().change_scene("res://Objects/Levels/Level_03.tscn")
	#else:
	#	get_tree().change_scene("res://Objects/Levels/Level_01.tscn")



func _on_Hurtbox_area_entered(area: Area2D) -> void:
	#this one connects to spikes and enemies.
	print("bonked by enemy")
	die()
	#probably don't need the HP, but its future proofing for health.
	#var dam = area.get("damage")
	#if dam != null:
	#	GlobalVars.hp -= area.damage
	#	if GlobalVars.hp <= 0:
	#		die()
		#learn how groups are made.
		#enemy ollision layer bit.
		#GlobalVars.HP -=1 #may try this if this other method doesn't work.
