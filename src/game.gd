extends Node2D

func _ready():
	# Preconfigure game.
	Lobby.player_loaded.rpc_id(1) # Tell the server that this peer has loaded.
	
	var ip = get_local_ip()
	$LocalIP.text = ip
	$PlayerName.text = generate_random_name()
	Lobby.name = $PlayerName.text

# Called only on the server.
func start_game():
	# All peers are ready to receive RPCs in this scene.
	pass

func get_local_ip():
	for address in IP.get_local_addresses():
		if not address.begins_with("127") and address.split('.').size() == 4:
			return address

func generate_random_name():
	var chars = 'abcdefghijklmnopqrstuvwxyz'
	var word: String
	var n_char = len(chars)
	for i in range(8):
		word += chars[randi()% n_char]
	return word

func _on_player_name_text_changed() -> void:
	Lobby.name = $PlayerName.text
	print("Name changed: " + $PlayerName.text)
