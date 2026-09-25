extends CharacterBody2D

@export var speed: float = 100.0
@export var distance: float = 35.0
@export var max_health: int = 50
@export var damage: int = 10
@export var damage_cooldown: float = 1.0

var health: int
var last_damage_time: float = 0.0
@onready var player = get_node("../Player")

func _ready():
	health = max_health

func _physics_process(delta: float) -> void:
	is_on_contact()
	var offset = player.global_position - global_position
	velocity = offset.normalized() * speed
	move_and_slide()

func is_on_contact(): 
	if global_position.distance_to(player.global_position) <= distance:
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - last_damage_time >=damage_cooldown:
			player.take_damage(damage)
			last_damage_time = current_time
			
func die() -> void:
	print("Il nemico è morto")

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy Health: %d" % health)
	if health <= 0:
		queue_free()
