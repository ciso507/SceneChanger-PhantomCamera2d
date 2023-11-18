extends CanvasLayer


# Called when the node enters the scene tree for the first time.
var _scene
var sceneName:String

func _ready():
	pass # Replace with function body.
	if _scene != null:
		print(_scene)
		_scene.queue_free()
		print(_scene)
	await get_tree().create_timer(0.50).timeout
	ZETA.load_screen(self, sceneName)
	print("excellent")
	#await 
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
