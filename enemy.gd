extends CharacterBody2D

@export var speed: float = 100.0
@export var distance: float = 35.0
@export var damage: int = 10
@export var damage_cooldown: float = 1.0
@onready var HealhtBar=$HealthBar
var Strength:int=12
var Dexterity:int=12
var Intelligence:int=8
var Constitution:int=14
var Wisdom:int=8
var Charisma:int=8
var health: int
var last_damage_time: float = 0.0
@onready var player = get_node("../Player")
@export var max_health: int = 50+(Constitution-10)*10

func _ready():
	health = max_health
	HealhtBar.max_value=max_health
	HealhtBar.value=health

func _physics_process(delta: float) -> void:
	is_on_contact()
	var offset = player.global_position - global_position
	velocity = offset.normalized() * speed
	move_and_slide()

func is_on_contact(): 
	if global_position.distance_to(player.global_position) <= distance:
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - last_damage_time >=damage_cooldown:
			if randi_range(1, 20)+(Dexterity-10)/2 >= player.AC():
				player.take_damage(damage)
				print("Enemy Damage: %d" % damage)
			else:
				print("Enemy Attack Missed")
			last_damage_time = current_time
			
func die() -> void:
	print("Il nemico è morto")

func take_damage(amount: int) -> void:
	health -= amount
	HealhtBar.value=health
	print("Enemy Health: %d" % health)
	if health <= 0:
		queue_free()
func AC()->int:
	return 10 + (Dexterity - 10)/2