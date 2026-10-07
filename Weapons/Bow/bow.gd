class_name Bow
extends Weapon


func _ready() -> void:
	super._ready()
	attack_cooldown = 1
	attack_damage = 8
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func attack(direction: Vector2) -> void:
	if can_attack :
		can_attack = false
		var arrow = preload("res://Weapons/Arrow/Arrow.tscn").instantiate()	
		arrow.global_position = global_position
		arrow.rotation = global_rotation
		arrow.damage = randi_range(1, attack_damage)+(player.Dexterity-10)*2
		print("Arrow Damage: %d" % arrow.damage)
		get_tree().current_scene.add_child(arrow)
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true
