extends Control

func _ready() -> void:
	Input.set_custom_mouse_cursor(preload("res://art/GGJ素材/锚点/maodian2.png"),0,Vector2(31,31))


func _on_producer_pressed() -> void:
	$"Buttons/制作人名单（如果用的上的话）".visible=true
	pass # Replace with function body.
