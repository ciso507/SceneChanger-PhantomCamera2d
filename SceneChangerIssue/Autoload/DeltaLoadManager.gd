extends Node





var _load_screen_path =  "res://DeltaSceneChanger/delta_loading_screen.tscn"
var _load_screen = load(_load_screen_path)




func add_load_scene(scene_path:String) -> void:
	var new_loading_screen = _load_screen.instantiate()
	#new_loading_screen.stringa = scene_path
	get_tree().get_root().add_child(new_loading_screen)
	new_loading_screen.load_scene(scene_path)
	
	

