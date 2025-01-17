extends RayCast2D

const RAYCAST_LENGTH:int=3000
var one_shoot:bool=true

func _physics_process(delta: float) -> void:
	if self.is_colliding() && one_shoot:
		var collider=self.get_collider()
		if is_instance_valid(collider):
			if collider.is_in_group("enemy"):
				var h=NA.calculate_health("player","enemy")
				one_shoot=false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		raycast_shoot()

func raycast_shoot():
	self.enabled=true
	one_shoot=true
	var mouse_pos:Vector2=get_viewport().get_mouse_position()
	var local_mouse_pos:Vector2=self.to_local(mouse_pos).normalized()
	self.target_position=local_mouse_pos*RAYCAST_LENGTH
	await get_tree().create_timer(0.5).timeout
	self.enabled=false
