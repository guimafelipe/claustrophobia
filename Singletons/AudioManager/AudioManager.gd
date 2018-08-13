extends Node

func _ready():
	$Hurt.stream.set_loop(false)
	pass

func play_background_music():
	stop_other_musics($BackgroundMusic)
	if $BackgroundMusic.playing:
		return
	$BackgroundMusic.stream.set_loop(true)
	$BackgroundMusic.play()

func stop_background_music():
	$BackgroundMusic.stop()

func play_background_cutscene():
	stop_other_musics($BackgroundCutscene)
	$BackgroundCutscene.stream.set_loop(true)
	$BackgroundCutscene.play()

func stop_background_cutscene():
	$BackgroundCutscene.stop()

func play_background_menu():
	stop_other_musics($BackgroundMenu)
	if $BackgroundMenu.playing:
		return
	$BackgroundMenu.stream.set_loop(true)
	$BackgroundMenu.play()

func stop_background_menu():
	$BackgroundMenu.stop()

func stop_other_musics(node):
	for noh in get_children():
		if noh.name.begins_with("Background") and noh != node:
			noh.stop()

func play_sound(name):
	var toplay = get_node(name)
	if toplay:
		toplay.play()

func play_gnome_voice():
	$FalasGnomo.play_gnome_voice()