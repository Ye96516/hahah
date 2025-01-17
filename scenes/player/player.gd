class_name Player extends CharacterBody2D

@onready var ray_cast_2d: RayCast2D = %RayCast2D

var direction:Vector2

func _ready() -> void:
	NA.entity_death.connect(on_death)
	ray_cast_2d.enabled=false

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left","move_right","move_top","move_down")
	velocity= direction * NA.player["speed"]*delta
	
	move_and_slide()




func on_death(n):
	if n=="player":
		self.queue_free()
