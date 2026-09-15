extends Area2D

# 1. Carregamos o tiro novo que você acabou de criar!
var cena_tiro_inimigo = preload("res://laser_inimigo.tscn")

func _ready() -> void:
	# 2. Criamos um "despertador" (Timer) invisível para cada inimigo
	var timer_tiro = Timer.new()
	
	# Ele vai escolher um tempo aleatório entre 5 e 15 segundos para atirar
	timer_tiro.wait_time = randf_range(5.0, 15.0)
	timer_tiro.autostart = true
	timer_tiro.timeout.connect(atirar)
	add_child(timer_tiro)

# Note que apagamos a função _process(delta)! Assim eles ficam PARADOS.

func atirar() -> void:
	var tiro = cena_tiro_inimigo.instantiate()
	tiro.global_position = global_position
	get_parent().add_child(tiro)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("tiro"):
		
		# ESSA É A LINHA NOVA: avisa a fase (game.gd) para somar 100 pontos!
		get_parent().adicionar_pontos(100)
		
		area.queue_free()
		queue_free()
