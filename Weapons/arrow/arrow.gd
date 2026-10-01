extends Node2D

var start_time:float=0.0
@export var speed: float = 500.0
var damage: int = 0
func _ready()->void:
	start_time=Time.get_ticks_msec()

func _physics_process(delta: float) -> void:
	if Time.get_ticks_msec()-start_time>10000:
		queue_free()
	var direction := Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta


func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()