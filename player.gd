extends CharacterBody2D

@onready var weapon_holder: Node2D = $WeaponHolder
@export var speed: float =200.0
@export var max_health: int = 100
var health: int
var current_weapon: Weapon
func _ready():
	health = max_health
	current_weapon = $WeaponHolder/sword



func die() -> void:
	print("Il Player è morto")

func take_damage(amount: int) -> void:
	health -= amount
	print("Player Health: %d" % health)
	if health <= 0:
		die()
	

func attack() -> void:
	current_weapon.attack(Vector2.ZERO)
	print("Player Attacks")


func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("attack"):
		attack()
	
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var Mouse_direction = get_global_mouse_position()- global_position
	global_rotation = Mouse_direction.angle()
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
