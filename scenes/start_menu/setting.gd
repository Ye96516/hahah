extends Button

@onready var setting:=preload("res://scenes/setting/setting.tscn")
var setting_ins:Variant

func _ready() -> void:
	setting_ins=setting.instantiate()
	owner.get_parent().call_deferred("add_child",setting_ins)
	setting_ins.visible=false

func _on_pressed() -> void:
	setting_ins.visible=true
	pass # Replace with function body.
