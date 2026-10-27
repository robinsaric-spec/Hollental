# Hollental – Projektkontext für Cloud-Sessions

Hollental ist ein 3D-RPG in **Godot 4** (GDScript). Die Source of Truth liegt **lokal beim Entwickler**.
Dieses Repo ist nur ein **Austausch-Repo** für abgeschlossene UI-Aufgaben: kein Asset-Stand, keine Map.

## Regeln
- Immer auf einem eigenen Branch arbeiten (`cloud/<aufgabe>`), nie auf `main`.
- Nur in dem Ordner der Aufgabe arbeiten (siehe `docs/aufgaben.md`). Keine anderen Dateien ändern.
- Keine Binärdateien (`.blend`, `.glb`, große Texturen). Platzhalter per Code/Farbe/`ColorRect` verwenden.
- Szenen (`.tscn`) und Ressourcen (`.tres`) als Text; Skripte in GDScript mit statischer Typisierung.
- Kommunikation mit dem Rest des Spiels nur über **Signale** und wenige öffentliche Funktionen (Schnittstelle in der jeweiligen Aufgabe dokumentieren).
- Ergebnis wird vom Entwickler manuell in das lokale Projekt übernommen.

## Ordner
- `ui/theme/` gemeinsames Godot-Theme (`hollental_theme.tres`), Farben, Fonts (Platzhalter)
- `ui/main_menu/` Startbildschirm
- `ui/loading/` Ladebildschirm
- `ui/battle/` Kampf-HUD
- `docs/` Briefings und Designentscheidungen

## Noch offen (vom Entwickler zu ergänzen)
Stimmung/Setting, Referenzen, Farbpalette, Schrift, Eingabe-Aktionen, Kampfsystem (rundenbasiert?), Party-Größe.
