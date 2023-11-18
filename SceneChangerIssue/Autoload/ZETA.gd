extends Node


const GAME_SCENES = {
	"init_title": "res://Scenes/MainMenu.tscn", #"res://addons/dialogue_manager/test_scene.tscn"
	"3dTest": "res://Scenes/3_dscene.tscn"
}

var loading_screenx = preload("res://ZetaSceneChanger/loading_screen.tscn")
var EMPTY_SCENE = preload("res://Scenes/EmptyScene.tscn")

func add_empty_scene(current_scene, next_scene:String):
	var e_scene_instance = EMPTY_SCENE.instantiate()
	e_scene_instance.sceneName = next_scene
	e_scene_instance._scene = current_scene
	get_tree().get_root().call_deferred("add_child", e_scene_instance)
#	await get_tree().create_timer(0.45).timeout
	if current_scene != null:
		current_scene.queue_free()
	


func load_screen(current_scene, next_scene):
	get_tree().paused = false
	#create a new loading instance
	print(current_scene, "before 1")
	var loading_screen_instance = loading_screenx.instantiate()
	loading_screen_instance.sceneName = GAME_SCENES[next_scene]
	loading_screen_instance.old_scene = current_scene
	get_tree().get_root().call_deferred("add_child", loading_screen_instance)
#	await get_tree().create_timer(0.45).timeout
	if current_scene != null:
		current_scene.queue_free()
