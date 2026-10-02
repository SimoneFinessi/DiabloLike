extends CanvasLayer

@onready var ammo_label = $Ammo
@onready var player = get_parent().get_node("Player")
@onready var health_bar=$HealthBar
@onready var gold =$Gold
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = player.max_health
	gold.text="Gold: "+str(player.gold)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ammo_label.text="Ammo: "+str(player.ammo)
	health_bar.value=player.health
	gold.text="Gold: "+str(player.gold)
