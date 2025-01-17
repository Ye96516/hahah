extends CharacterBody2D

@onready var player:Player=get_tree().get_first_node_in_group("player")
var direction:Vector2

func _ready() -> void:
	NA.entity_death.connect(on_death)

func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		direction=(player.global_position-self.global_position).normalized()
		velocity=direction*NA.enemy["speed"]*delta

	move_and_slide()

func on_death(n):
	if n=="enemy":
		self.queue_free()
