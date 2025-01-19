extends StateBase
"""
此状态为death
"""

func enter():
	var t:Tween=get_tree().create_tween()
	t.tween_property(owner,"modulate:a",0,2)
	t.tween_callback(change_to_start)
	pass

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	pass

func physical_process_update(_delta: float) -> void:
	pass

func change_to_start():
	get_tree().change_scene_to_file(("res://scenes/start_menu/start_menu.tscn"))
