extends Area2D

# Coloque aqui a velocidade que você tinha escolhido antes!
@export var velocidade: float = 250.0 

func _process(delta: float) -> void:
	# O tiro do inimigo vai para a ESQUERDA (sinal de menos!)
	position.x -= velocidade * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

# Essa é a função nova que o Godot conectou!
func _on_body_entered(body: Node2D) -> void:
	# Verificamos se o "corpo" que o laser bateu se chama "Player"
	if body.name == "Player":
		# Avisa o game para perder uma vida e some com o tiro!
		get_parent().perder_vida()
		queue_free()
