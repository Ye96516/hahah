extends RayCast2D

const RAYCAST_LENGTH:int=3000
var one_shoot:bool=true

@onready var bullet_quantity: Label = %BulletQuantity

func _ready() -> void:
	bullet_quantity.text=str(owner.self_res.entity["quantity"])

func _physics_process(delta: float) -> void:
	if self.is_colliding() && one_shoot:
		var collider=self.get_collider()
		if is_instance_valid(collider):
			if collider.is_in_group("enemy"):
				var h=NA.calculate_health(owner.self_res,collider.self_res)
				one_shoot=false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		owner.self_res.entity["quantity"]-=1
		bullet_quantity.text=str(owner.self_res.entity["quantity"])
		raycast_shoot()

func raycast_shoot():
	one_shoot=true
	var mouse_pos:Vector2=get_viewport().get_mouse_position()
	var local_mouse_pos:Vector2=self.to_local(mouse_pos).normalized()
	self.target_position=local_mouse_pos*RAYCAST_LENGTH
