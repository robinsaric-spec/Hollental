class_name OptionsMenu
extends Control
## Optionen-Unterseite: Lautstaerke, Fenstermodus, Tastenbelegung (Grundgeruest).
## Lautstaerke und Fenstermodus werden in user://settings.cfg gespeichert.
## Tastenbelegung gilt nur fuer die laufende Sitzung (Speichern folgt mit dem Eingabe-System).

signal closed

const SETTINGS_PATH := "user://settings.cfg"
const WINDOW_MODES: Array[String] = ["Fenster", "Vollbild", "Randloses Fenster"]
const BUSES: Dictionary = {"Master": "Master", "Music": "Music", "SFX": "SFX"}

@onready var _tabs: TabContainer = %Tabs
@onready var _window_mode: OptionButton = %WindowModeOption
@onready var _bindings: VBoxContainer = %BindingsList
@onready var _back: Button = %BackButton
@onready var _sliders: Dictionary = {
	"Master": [%MasterSlider, %MasterValue],
	"Music": [%MusicSlider, %MusicValue],
	"SFX": [%SfxSlider, %SfxValue],
}

var _config := ConfigFile.new()
var _rebind_action := &""
var _rebind_button: Button = null


func _ready() -> void:
	visible = false
	_config.load(SETTINGS_PATH)
	for key: String in _sliders:
		var slider: HSlider = _sliders[key][0]
		slider.value = float(_config.get_value("audio", key, 80.0))
		slider.value_changed.connect(_on_volume_changed.bind(key))
		_on_volume_changed(slider.value, key)
	for mode in WINDOW_MODES:
		_window_mode.add_item(mode)
	_window_mode.select(int(_config.get_value("display", "window_mode", 0)))
	_window_mode.item_selected.connect(_on_window_mode_selected)
	_apply_window_mode(_window_mode.selected)
	_back.pressed.connect(close)
	_build_bindings()


func open() -> void:
	visible = true
	_tabs.current_tab = 0
	(_sliders["Master"][0] as HSlider).grab_focus()


func close() -> void:
	_cancel_rebind()
	_config.save(SETTINGS_PATH)
	visible = false
	closed.emit()


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if _rebind_button != null:
		_handle_rebind_input(event)
	elif event.is_action_pressed("ui_cancel"):
		close()
		get_viewport().set_input_as_handled()


func _on_volume_changed(value: float, key: String) -> void:
	(_sliders[key][1] as Label).text = "%d %%" % int(value)
	_config.set_value("audio", key, value)
	var bus := AudioServer.get_bus_index(BUSES[key])
	if bus == -1:
		return
	AudioServer.set_bus_mute(bus, value <= 0.0)
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100.0))


func _on_window_mode_selected(index: int) -> void:
	_config.set_value("display", "window_mode", index)
	_apply_window_mode(index)


func _apply_window_mode(index: int) -> void:
	match index:
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		_:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _build_bindings() -> void:
	var actions: Array[StringName] = []
	for action in InputMap.get_actions():
		if not String(action).begins_with("ui_"):
			actions.append(action)
	actions.sort()
	if actions.is_empty():
		var hint := Label.new()
		hint.theme_type_variation = &"MutedLabel"
		hint.text = "Noch keine Eingabe-Aktionen im Projekt definiert."
		_bindings.add_child(hint)
		return
	for action in actions:
		var row := HBoxContainer.new()
		var label := Label.new()
		label.text = String(action).capitalize()
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var button := Button.new()
		button.custom_minimum_size = Vector2(220, 0)
		button.text = _binding_text(action)
		button.pressed.connect(_start_rebind.bind(action, button))
		row.add_child(label)
		row.add_child(button)
		_bindings.add_child(row)


func _binding_text(action: StringName) -> String:
	var events := InputMap.action_get_events(action)
	return events[0].as_text() if not events.is_empty() else "—"


func _start_rebind(action: StringName, button: Button) -> void:
	_cancel_rebind()
	_rebind_action = action
	_rebind_button = button
	button.text = "Taste druecken …"


func _cancel_rebind() -> void:
	if _rebind_button != null:
		_rebind_button.text = _binding_text(_rebind_action)
	_rebind_button = null
	_rebind_action = &""


func _handle_rebind_input(event: InputEvent) -> void:
	if not event.is_pressed() or event is InputEventMouseMotion:
		return
	get_viewport().set_input_as_handled()
	if event.is_action_pressed("ui_cancel"):
		_cancel_rebind()
		return
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventMouseButton:
		InputMap.action_erase_events(_rebind_action)
		InputMap.action_add_event(_rebind_action, event)
		_rebind_button.text = _binding_text(_rebind_action)
		_rebind_button = null
		_rebind_action = &""
