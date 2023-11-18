extends CanvasLayer
class_name loading_screen_delta

signal safe_to_load
signal progress_changed(value)

@onready var animPlayer = $AnimationPlayer
@onready var progress_bar = $Control/ProgressBar

var progress :Array =[]
var sceneName: String

var loading_status: int
var old_scene




#func _initx(scene):
	#scene.queue_free()

func _ready():
	#set_process(false)
	if old_scene != null:
		old_scene.queue_free()
	ResourceLoader.load_threaded_request(sceneName)
	
	self.progress_changed.connect(_received_reached)



func _process(delta):
	loading_status = ResourceLoader.load_threaded_get_status(sceneName, progress)
#	$Label.text = str(floor(progress[0]*100)) + "%"
#	progress_bar.value = floor(progress[0]*100)
	
	match loading_status:
		0,2:
			print("ERROC didnt loaded")
			set_process(false)
			return
		
		1:
			progress_bar.value = round(progress[0] * 100)
			#print(progress, "valuesss z", progress[0])
			
			
		3:
			emit_signal("progress_changed", 1.0)
			var new_scene = ResourceLoader.load_threaded_get(sceneName)
			get_tree().change_scene_to_packed(new_scene)
			#emit_signal("load_done")

			#progress_bar.value = 100

			set_process(false)


		





func _received_reached(value):
	fade_out_loading_screen()

	


func _loader_screen():
	pass


func fade_out_loading_screen():
	set_tween()
	await get_tree().create_timer(1.4).timeout
	animPlayer.play("fade_out")
	await animPlayer.animation_finished
	queue_free()


func set_tween():
	var tween = create_tween()
	tween.parallel().tween_property(progress_bar, "value", 100, 0.6).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(progress_bar, "size", Vector2(450, 45), 0.6).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(progress_bar, "position:x", 420, 0.6).set_trans(Tween.TRANS_ELASTIC)
