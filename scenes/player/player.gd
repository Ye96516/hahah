class_name Player extends CharacterBody2D

@onready var ray_cast_2d: RayCast2D = %RayCast2D
@onready var state_machine: StateMachine = $StateMachine
@export var self_res:EntityAtrributes

var direction:Vector2
var can_pick:bool
var bullet:Bullet

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left","move_right","move_top","move_down")
	velocity= direction * self_res.entity["speed"]*delta
	move_and_slide()

	if Input.is_action_just_pressed("pick_up") &&can_pick:
		self_res.entity["ap"]=bullet.attri["ap"]
		self_res.entity["quantity"]=bullet.attri["quantity"]
		self_res.entity["atk_speed"]=bullet.attri["atk_speed"]
		self_res.entity["reload_cd"]=bullet.attri["reload_cd"]
		bullet.queue_free()

func on_death(n):
	if n=="player":
		state_machine.change_state("Death")
