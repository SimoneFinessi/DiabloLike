class_name Bow
extends Weapon

var Start_ammo:int=20
var ammo=Start_ammo
func _ready() -> void:
	attack_cooldown = 1
	attack_damage = 20
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_attack and ammo>0:
		if Input.is_action_just_pressed("attack"):
			can_attack = false
			var arrow = preload("res://Weapons/Arrow/Arrow.tscn").instantiate()
			ammo -=1
			arrow.global_position = global_position
			arrow.rotation = global_rotation
			arrow.damage = attack_damage
			get_tree().current_scene.add_child(arrow)
			await get_tree().create_timer(attack_cooldown).timeout
			can_attack = true
