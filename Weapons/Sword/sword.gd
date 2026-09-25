class_name Sword
extends Weapon

@onready var attack_area = $AttackArea
@onready var collision_shape = attack_area.get_node("CollisionShape2D")
func _ready() -> void:
	attack_cooldown = 0.5
	attack_damage = 20

func attack(direction: Vector2) -> void:
	if can_attack:
		can_attack = false
		collision_shape.disabled = false
		await get_tree().physics_frame
		var enemy = attack_area.get_overlapping_bodies()
		for body in enemy:
			if body.has_method("take_damage"):
				body.take_damage(attack_damage)
		await get_tree().create_timer(0.2).timeout
		collision_shape.disabled = true
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true