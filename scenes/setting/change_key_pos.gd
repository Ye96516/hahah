extends Control

@onready var move_right: Button = %MoveRight

enum actions{
	move_right,
	move_left,
	move_top,
	move_down,
	pick_up,
	pause,
	speed_up,
	change_scene,
}

var current_action=actions.move_right

var sl:SLSystem=SLSystem.new()

func _ready() -> void:
	load_changed_key()
	pass

func _on_move_right_pressed() -> void:
	current_action=actions.move_right

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		match current_action:
			actions.move_right:
				change_action_event("move_right",event,move_right)
				sl.save_data("move_right_key",event)

func load_changed_key():
	if sl.has_key("move_right_key"):
		var e=sl.load_data("move_right_key")
		change_action_event("move_right",e,move_right)

func change_action_event(action:String,e:InputEventKey,node:Node):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action,e)
	node.text=InputMap.action_get_events(action)[0].as_text()
