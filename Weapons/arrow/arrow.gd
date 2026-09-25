extends Node2D


@export var speed: float = 500.0
var damage: int = 0

func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()