extends StateBase

@onready var player:Player=get_tree().get_first_node_in_group("player")
@export var speed:int=10000


var dir:Vector2
var is_right:bool

func enter():
	print(owner.p2,owner.p1)
	pass

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	pass

func physical_process_update(delta: float) -> void:
	if is_instance_valid(player):
		owner.velocity=owner.direction*owner.self_res.entity["speed"]*delta
	
	if is_right:
		dir=(owner.p2-owner.position).normalized()
		#print("right",(owner.p2-owner.position).length())
		if (owner.p2-owner.position).length()<2:
			is_right=!is_right
	else:
		dir=(owner.p1-owner.position).normalized()
		#print("left",(owner.p2-owner.position).length())
		if (owner.p1-owner.position).length()<2:
			is_right=!is_right
	owner.velocity=dir*delta*speed
	
	pass
