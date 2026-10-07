class_name Sword
extends Weapon

@onready var attack_area = $AttackArea
@onready var collision_shape = attack_area.get_node("CollisionShape2D")
func _ready() -> void:
	super._ready()
	attack_cooldown = 0.5
	attack_damage = 8

func attack(direction: Vector2) -> void:
	if can_attack:
		can_attack = false
		var start_rotation = rotation
		var attack_rotation  = start_rotation+ deg_to_rad(90)
		collision_shape.disabled = false
		var tween = create_tween()
		tween.tween_property(self,"rotation",attack_rotation ,0.2)
		await tween.finished
		await get_tree().physics_frame
		var enemy = attack_area.get_overlapping_bodies()
		for body in enemy:
			if body.has_method("take_damage"):
				if randi_range(1, 20)+((player.Strength-10)*2) >= body.AC():
					body.take_damage(randi_range(1, attack_damage)+(player.Strength-10)*2)
				else:
					print("Attack Missed")
		tween = create_tween()
		tween.tween_property(self,"rotation",start_rotation,0.3)
		await tween.finished
		await get_tree().create_timer(0.2).timeout
		collision_shape.disabled = true
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
