class_name Arrow
extends Weapon

var start_time:float=0.0
@export var speed: float = 500.0
var damage: int = 0


func _ready()->void:
	super._ready()
	start_time=Time.get_ticks_msec()

func _physics_process(delta: float) -> void:
	if Time.get_ticks_msec()-start_time>10000:
		queue_free()
	var direction := Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta


func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		if randi_range(1, 20)+(player.Dexterity-10)/2 >= body.AC():
			body.take_damage(damage)
			print("Arrow Damage: %d" % damage)
		else:
			print("Arrow Attack Missed")
		
		queue_free()