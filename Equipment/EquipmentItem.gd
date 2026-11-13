class_name EquipmentItem
extends Resource

enum Slot{
    HEAD,
    CHEST,
    LEGS,
    FEET,
    RING
}

@export var item_name: String = ""
@export var slot: Slot

@export var stat_bonuses: Dictionary = {}
