extends CanvasLayer

signal loading_screen_has_full_coverage
signal progress_changed(progress)
signal load_done


@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $Control/ProgressBar


var _load_screen_path =  "res://DeltaSceneChanger/delta_loading_screen.tscn"
var _load_screen = load(_load_screen_path)
var _loaded_resource: PackedScene
var _scene_path:String
var _progress:Array = []

@export var use_sub_threads:bool = false


const GAME_SCENES = {
	"init_title": "res://Scenes/MainMenu.tscn", #"res://addons/dialogue_manager/test_scene.tscn"
	"3dTest": "res://Scenes/3_dscene.tscn"
}

var loading_screenx = preload("res://ZetaSceneChanger/loading_screen.tscn")
var EMPTY_SCENE = preload("res://Scenes/EmptyScene.tscn")



func load_scene(scene_path:String) -> void:
	set_process(false)
	_scene_path = GAME_SCENES[scene_path]

	self.progress_changed.connect(_update_progress_bar)
	self.load_done.connect(_start_outro_animation)
	
	await Signal(self, "loading_screen_has_full_coverage")
	start_load()




func start_load():
	var state = ResourceLoader.load_threaded_request(_scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)



func _process(_delta):
	var load_status = ResourceLoader.load_threaded_get_status(_scene_path, _progress)
#	$Label.text = str(floor(progress[0]*100)) + "%"
#	progress_bar.value = floor(progress[0]*100)
	
	match load_status:
		0,2:
			print("ERROC didnt loaded")
			set_process(false)
			return
		
		1:
			emit_signal("progress_changed", _progress[0])
			print(_progress[0], "1 LOADING", _progress)
			#print(progress, "valuesss z", progress[0])
			
			
		3:
			
			_loaded_resource = ResourceLoader.load_threaded_get(_scene_path)
			print(_progress[0], "1 LOADING finalle", _scene_path, _progress, "...", _loaded_resource)
			emit_signal("progress_changed", 1.0)
			emit_signal("load_done")
			get_tree().change_scene_to_packed(_loaded_resource)
			#emit_signal("load_done")

			#progress_bar.value = 100

			set_process(false)
			return












func _update_progress_bar(new_value:float)->void:
	progress_bar.set_value_no_signal(new_value*100)


func _start_outro_animation() ->void:
	set_tween()
	await Signal(animation_player, "animation_finished")
	animation_player.play("fade_out")
	await Signal(animation_player, "animation_finished")
	self.queue_free()


func set_tween():
	var tween = create_tween()
	tween.parallel().tween_property(progress_bar, "value", 100, 0.6).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(progress_bar, "size", Vector2(550, 45), 0.6).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(progress_bar, "position:x", 420, 0.6).set_trans(Tween.TRANS_ELASTIC)
