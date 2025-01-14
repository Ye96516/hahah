extends Button

enum mouse_pic{
	normal,
	godot,
}
var current_pic:int=mouse_pic.normal

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	match current_pic:
		mouse_pic.normal:
			current_pic=mouse_pic.godot
			Input.set_custom_mouse_cursor(preload("res://icon.svg"))
		mouse_pic.godot:
			current_pic=mouse_pic.normal
			Input.set_custom_mouse_cursor(null)
