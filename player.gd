extends CharacterBody2D
const EquipmentItemScript = preload("res://Equipment/EquipmentItem.gd")
@onready var weapon_holder: Node2D = $WeaponHolder
@export var speed: float =200.0
var dodge_speed: float = 500.0
var dodge_duration: float = 0.15
var health: int
@onready var sword:Weapon=$WeaponHolder/sword
@onready var bow:Weapon=$WeaponHolder/Bow
var Start_ammo:int=30
var ammo=Start_ammo
var gold:int=0
var current_weapon: Weapon
var dodge_cooldown:float=1.0
var can_dodge:bool=true
var is_dodging:bool=false
var modifier:float=1.0
var Strength:int=16
var Dexterity:int=13
var Intelligence:int=12
var Constitution:int=14
var Wisdom:int=10
var Charisma:int=10
var inventory: Array[EquipmentItemScript] = []
var equipment: Dictionary = {
    EquipmentItemScript.Slot.HEAD: null,
    EquipmentItemScript.Slot.CHEST: null,
    EquipmentItemScript.Slot.LEGS: null,
    EquipmentItemScript.Slot.FEET: null
}
var rings: Array[EquipmentItemScript] = []
@export var max_health: int = 100+(Constitution-10)*10
func _ready():
	inventory.resize(20)
	rings.resize(10)
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
func AC()->int:
	return 10 + (getFullAttribute("Dexterity") - 10)/2

func getFullAttribute(attribute_name:String)->int:
	var bonus:int=0
	for equip in equipment.values():
		if equip !=null:
			bonus+=equip.stat_bonuses.get(attribute_name,0)
	for ring in rings:
		if ring !=null:
			bonus+=ring.stat_bonuses.get(attribute_name,0)
	match attribute_name:
		"Strength":
			return Strength + bonus
		"Dexterity":
			return Dexterity + bonus
		"Intelligence":
			return Intelligence + bonus
		"Constitution":
			return Constitution + bonus
		"Wisdom":
			return Wisdom + bonus
		"Charisma":
			return Charisma + bonus
	return 0
func equip_item(index:int) -> void:
	var item: EquipmentItemScript = inventory[index]
	if item.slot in equipment:
		if equipment[item.slot]!=null:
			unequip_item(item.slot)
		equipment[item.slot]=item
		inventory[index]=null
	
func equip_Ring(InventoryIndex:int, RingIndex:int) -> void:
	if rings[RingIndex]!=null:
		unequip_Ring(RingIndex)
	rings[RingIndex]=inventory[InventoryIndex]
	inventory[InventoryIndex]=null

func unequip_item(slot:int)-> void:
	var indexNull=inventory.find(null)
	if indexNull != -1:
		inventory[indexNull]=equipment[slot]
	else:
		inventory.append(equipment[slot])
	equipment[slot]=null

func unequip_Ring(index:int)->void:
	var indexNull=inventory.find(null)
	if indexNull != -1:
		inventory[indexNull]=rings[index]
	else:
		inventory.append(rings[index])
	rings[index]=null

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
