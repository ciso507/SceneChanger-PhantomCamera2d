extends Node3D

@export var can_press:bool = true

@onready var mage = $Mage
@onready var mage_anim = $Mage/AnimationPlayer

@onready var knight = $Knight
@onready var knight_anim = $Knight/AnimationPlayer

var string: String = "init_title"

func _ready():
	$Prefabs/Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_zeta_pressed():
	if can_press:
		can_press = false
		#Utils.load_screen(self, "init_title")
		ZETA.add_empty_scene(self, string)



func _on_delta_pressed():
	if can_press:
		can_press = false
		DeltaLoadManager.add_load_scene(string)

@onready var cam_1 = $Prefabs/CAM1
@onready var cam_2 = $Prefabs/CAM2

func _input(event):
		if event.is_action_pressed("ui_left"):
			#_manage_pressed()
			cam_1.set_priority(0)
			cam_2.set_priority(20)
			
		if event.is_action_pressed("ui_right"):
			#_manage_pressed()
			cam_1.set_priority(20)
			cam_2.set_priority(0)



func _on_timer_timeout():
	# Get a list of all animation names in the AnimationPlayer
	var mage_animation_names = mage_anim.get_animation_list()
	# Select a random animation from the list
	var mage_random_animation = mage_animation_names[randi() % mage_animation_names.size()]
	# Play the selected animation
	mage_anim.play(mage_random_animation)


	var knight_animation_names = knight_anim.get_animation_list()

	var knight_random_animation = knight_animation_names[randi() % knight_animation_names.size()]

	knight_anim.play(knight_random_animation)


