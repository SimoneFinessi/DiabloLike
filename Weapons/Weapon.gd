class_name Weapon
extends Node2D


@export var attack_damage: int 
@export var attack_cooldown: float 

var can_attack: bool = true

func attack(direction: Vector2) -> void:
	pass