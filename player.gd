extends CharacterBody2D

@onready var weapon_holder: Node2D = $WeaponHolder
@export var speed: float =200.0
var dodge_speed: float = 500.0
var dodge_duration: float = 0.15
@export var max_health: int = 100
var health: int
@onready var sword:Weapon=$WeaponHolder/sword
@onready var bow:Weapon=$WeaponHolder/Bow
var Start_ammo:int=20
var ammo=Start_ammo
var gold:int=0
var current_weapon: Weapon
var dodge_cooldown:float=1.0
var can_dodge:bool=true
var is_dodging:bool=false
func _ready():
	health = max_health
	current_weapon = sword
	sword.show()
	bow.hide()



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

func SwordActive()->void:
	current_weapon=sword
	sword.show()
	bow.hide()

func BowActive()->void:
	current_weapon=bow
	sword.hide()
	bow.show()

func dodge(direction: Vector2) -> void:
	print("Player Dodges")
	can_dodge=false
	is_dodging=true
	velocity = direction * dodge_speed
	await get_tree().create_timer(dodge_duration).timeout
	is_dodging = false
	await get_tree().create_timer(dodge_cooldown).timeout
	can_dodge = true

func _physics_process(delta: float) -> void:
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var Mouse_direction = get_global_mouse_position()- global_position
	global_rotation = Mouse_direction.angle()
	if not is_dodging:
		if direction:
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO

		if Input.is_action_just_pressed("mouseSinistro"):
			SwordActive()
			if current_weapon.can_attack:
				attack()
		elif Input.is_action_just_pressed("mouseDestro"):
			BowActive()
			if ammo > 0 and current_weapon.can_attack:
				ammo -= 1
				attack()
		elif Input.is_action_just_pressed("dodge") and can_dodge:
			dodge(direction)


	move_and_slide()
