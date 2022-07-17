extends Node

"""
Manages the playing of sound effects 
There can be multiple audio stream players wihch allows for sounds to be
played concurrently
"""

export(Array, Resource) var cutting_sounds = []
export(Resource) var applause_sound
export(Resource) var countdown_sound

# Number of audio players
export var num_channels = 1

var audio_players = []

var rng = RandomNumberGenerator.new()


signal players_finished()

func _ready():
	
	rng.randomize()
	
	# Create the specified number of audio stream players
	for _i in range(0, num_channels):
		var player = AudioStreamPlayer.new()
		player.bus = "Sound Effects"
		player.connect("finished", self, "_on_player_done")
		audio_players.append(player)
		
		add_child(player)
	
# Play a random sound from an array of sounds
func play_rand(sounds):
	
	# Don't try to play sounds if there are no sounds
	if sounds.size() <= 0:
		return
		
	# Pick a random number
	var index = rng.randi_range(0, sounds.size() - 1)
	
	
	play_sound(sounds[index])

# Play one sound
func play_sound(sound):
	var player = _get_audio_player()
	player.stream = sound
	player.play()

func is_playing():
	
	# Go through all of the audio players
	# If any of them are still playing, then return false
	
	for player in audio_players:
		if player.playing:
			return true
	return false
	
func _get_audio_player():
	
	# Go through all of the available audio players and get one that is free
	for player in audio_players:
		if !player.playing:
			
			return player
	
	return audio_players[0]

# This is called whenever an audio player is finished playing
# This is to replicate an individual audio stream player's "finished" signal
# but while tracking multiple audio payers which is used to determine 
# whether or not the sound effect player is still in the middle of playing sounds
func _on_player_done():
	
	# If all players are not playing, then the on_audio_done signal is fired
	for player in audio_players:
		if player.playing:
			return
			
	
	emit_signal("players_finished")
	
func play_cut_sound():
	play_rand(cutting_sounds)
	
func play_applause_sound():
	play_sound(applause_sound)
	
func play_countdown_sound():
	play_sound(countdown_sound)
