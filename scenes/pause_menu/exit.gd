extends Button


func _on_pressed() -> void:
	owner.visible=false
	get_tree().paused=false
