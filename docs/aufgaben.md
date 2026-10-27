# Aufgaben für Cloud-Sessions

Reihenfolge: 1 → 2 → 3 → 4. Alle bauen auf dem gemeinsamen Theme auf.

## 1. Theme + Startbildschirm (`ui/theme/`, `ui/main_menu/`)
- Stil festlegen: Farbpalette, Typografie, Button-Zustände (normal/hover/pressed/disabled), Panels.
- `hollental_theme.tres` erzeugen.
- `MainMenu.tscn` + `main_menu.gd`: Neues Spiel, Fortsetzen, Optionen, Beenden.
- Signale: `new_game_pressed`, `continue_pressed`, `options_pressed`, `quit_pressed`.
- Navigation per Tastatur/Controller/Maus, Fokus-Handling.
- Optionen-Unterseite: Lautstärke, Fenstermodus, Tastenbelegung (Grundgerüst).
- Vorher: HTML/SVG-Mockup-Varianten zur Auswahl in `docs/mockups/`.

## 2. Ladebildschirm (`ui/loading/`)
- `LoadingScreen.tscn` + `loading_screen.gd`.
- API: `load_scene(path: String)`; Signal `loading_finished(scene: PackedScene)`.
- Asynchron per `ResourceLoader.load_threaded_request`, Fortschrittsbalken, wechselnde Tipps/Lore-Texte (aus JSON).

## 3. Kampf-HUD (`ui/battle/`)
- `BattleHUD.tscn` + Skripte: HP/MP-Balken, Aktionsmenü, Zielauswahl, Skill-/Item-Liste, Turn-Order, Schadenszahlen, Statuseffekt-Icons.
- Schnittstelle: Signale `action_selected(action)`, `target_chosen(target)`; Funktionen `show_player_turn(character)`, `show_damage(target, amount)`.
- Test-Szene mit Dummy-Daten, damit das HUD ohne Kampflogik startet.

## 4. Review
- Konsistenz zwischen Menü, Laden und Kampf-HUD prüfen, Doku ergänzen.
