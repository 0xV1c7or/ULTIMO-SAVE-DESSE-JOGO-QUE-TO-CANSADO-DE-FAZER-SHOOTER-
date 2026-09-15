extends Area2D

@export var velocidade: float = 600.0

func _process(delta: float) -> void:
	# Move o tiro para a direita
	position.x += velocidade * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Apaga o tiro quando ele sai da tela para não gastar memória
	queue_free()
