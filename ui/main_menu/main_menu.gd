class_name MainMenu
extends Control
## Startbildschirm. Spiellogik haengt sich nur ueber die Signale ein.

signal new_game_pressed
signal continue_pressed
signal options_pressed
signal quit_pressed

## Ob ein Spielstand zum Fortsetzen existiert (vom Spiel setzen).
@export var continue_available := false : set = set_continue_available
## Beendet das Spiel nach `quit_pressed` selbst; abschalten, wenn das Spiel das uebernimmt.
@export var quit_on_quit_pressed := true

@onready var _menu: Control = %MenuColumn
@onready var _new_game: Button = %NewGameButton
@onready var _continue: Button = %ContinueButton
@onready var _options_button: Button = %OptionsButton
@onready var _quit: Button = %QuitButton
@onready var _options: OptionsMenu = %OptionsMenu


func _ready() -> void:
	for button: Button in [_new_game, _continue, _options_button, _quit]:
		button.mouse_entered.connect(_on_button_hovered.bind(button))
	_new_game.pressed.connect(func() -> void: new_game_pressed.emit())
	_continue.pressed.connect(func() -> void: continue_pressed.emit())
	_options_button.pressed.connect(_on_options_pressed)
	_quit.pressed.connect(_on_quit_pressed)
	_options.closed.connect(_on_options_closed)
	_apply_continue_state()
	_play_intro()


func set_continue_available(value: bool) -> void:
	continue_available = value
	if is_node_ready():
		_apply_continue_state()


## Setzt den Fokus auf den sinnvollsten Eintrag (Fortsetzen, sonst Neues Spiel).
func focus_default() -> void:
	(_continue if continue_available else _new_game).grab_focus()


func _apply_continue_state() -> void:
	_continue.disabled = not continue_available
	_continue.focus_mode = Control.FOCUS_ALL if continue_available else Control.FOCUS_NONE
	focus_default()


func _play_intro() -> void:
	_menu.modulate.a = 0.0
	var tween := create_tween()
	tween.tween_property(_menu, "modulate:a", 1.0, 1.2).set_trans(Tween.TRANS_SINE)


func _on_button_hovered(button: Button) -> void:
	if not button.disabled and not _options.visible:
		button.grab_focus()


func _on_options_pressed() -> void:
	options_pressed.emit()
	_options.open()


func _on_options_closed() -> void:
	_options_button.grab_focus()


func _on_quit_pressed() -> void:
	quit_pressed.emit()
	if quit_on_quit_pressed:
		get_tree().quit()
