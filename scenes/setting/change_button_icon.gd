extends Button

enum mouse_pic{
	normal,
	small_star,
	godot,
}
var current_pic:int=mouse_pic.small_star
var number:int

func _on_pressed() -> void:
	number+=1
	if number==1:
		Input.set_custom_mouse_cursor(preload("res://icon.svg"))
	elif number==2:
		Input.set_custom_mouse_cursor(null)
	elif number==3:
		Input.set_custom_mouse_cursor(preload("res://art/GGJ素材/锚点/maodian2.png"),0,Vector2(31,31))
	if number>=3:
		number=0
	
