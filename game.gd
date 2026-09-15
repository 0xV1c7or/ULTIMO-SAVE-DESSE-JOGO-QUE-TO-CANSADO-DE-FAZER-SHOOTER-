extends Node2D

var cena_inimigo = preload("res://inimigo.tscn")
var pontos: int = 0 
var vidas: int = 3  
var jogo_acabou: bool = false 

func _ready() -> void:
	# 1. Paramos o timer antigo para não chover inimigos soltos
	$SpawnTimer.stop() 
	# 2. Chamamos a função que cria o quadrado de inimigos de uma vez só
	gerar_horda()

func gerar_horda() -> void:
	# Aqui você pode mudar a quantidade! Coloquei 5 colunas e 5 linhas (25 inimigos)
	var colunas = 5
	var linhas = 5
	
	# Usamos a matemática para colocar um do lado/baixo do outro (Grid)
	for linha in range(linhas):
		for coluna in range(colunas):
			var inimigo = cena_inimigo.instantiate()
			
			# X começa em 750 (direita) e dá 80 pixels de distância para o lado
			var pos_x = 750 + (coluna * 80)
			
			# Y começa em 100 (topo) e dá 110 pixels de distância para baixo
			var pos_y = 100 + (linha * 110)
			
			inimigo.position = Vector2(pos_x, pos_y)
			add_child(inimigo)

# Mantemos a função velha do timer aqui embaixo, mas vazia (pass), só para o Godot não dar erro reclamando que ela sumiu
func _on_spawn_timer_timeout() -> void:
	pass

# Função que soma os pontos e atualiza o texto na tela!
func adicionar_pontos(valor: int) -> void:
	if not jogo_acabou:
		pontos += valor
		$"HUD/Pontuação".text = "SCORE: " + str(pontos)

# Função que gerencia as vidas do jogador e atualiza o número vermelho na tela!
func perder_vida() -> void:
	if jogo_acabou:
		return
		
	vidas -= 1
	
	# Atualiza o número vermelho no canto superior esquerdo na hora!
	$"HUD/VidasLabel".text = str(vidas)
	
	print("Vidas restantes: ", vidas)
	
	if vidas <= 0:
		jogo_acabou = true
		
		# Mostra o seu texto personalizado junto com o score final exato!
		$"HUD/GameOverScreen/ScoreFinalLabel".text = "O SEU SCORE FOI DE: " + str(pontos)
		
		# Mostra a tela de Game Over na tela!
		$"HUD/GameOverScreen".visible = true

# Função do Godot que escuta o teclado a qualquer momento para reiniciar
func _input(event: InputEvent) -> void:
	if jogo_acabou and event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		get_tree().reload_current_scene()
