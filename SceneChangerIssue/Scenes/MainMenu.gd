extends Node2D

@export var can_press:bool = true
var string: String = "3dTest"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_zeta_scene_pressed():
	if can_press:
		can_press = false
		ZETA.add_empty_scene(self, string)



func _on_delta_scene_pressed():
	if can_press:
		can_press = false
		DeltaLoadManager.add_load_scene(string)
		
