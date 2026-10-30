# Startbildschirm, Skizze 1

Interaktives HTML-Mockup für den Startbildschirm. Es passt zur Inventar-Skizze
(`docs/mockups/inventar/` auf dem Branch `claude/brave-mendel-s53t1y`): gleiche Farb-Tokens, Barlow und
Barlow Semi Condensed, Kupfer als Akzent, Holo-Cyan für Auswahl und Fokus,
Eckklammern, Kupferwinkel an den Fenstern, gleiche Fenster-Projektion.

`index.html` im Browser öffnen. Die Datei enthält alles, auch die Keyart
(als WebP eingebettet). Nur die Schriften kommen von Google Fonts.

## 4K und ganzer Bildschirm

- Die Keyart liegt in 3840 × 2160 vor. Das Original (1672 × 941) wurde mit Real-ESRGAN
  (Modell `x4plus_anime_6B`, für gezeichnete Bilder) hochgerechnet und zu 20 % mit einer
  weichen Vergrößerung gemischt, damit Nebel und Wolken nicht wie Plastik wirken. Danach wurde
  die Farbabstimmung in 4K neu eingerechnet.
- Die Szene wird in der vollen Auflösung des Bildschirms gezeichnet, auf einem 4K-Bildschirm also
  in 3840 × 2160, auch bei Windows-Skalierung (150 %, 200 %). Obergrenze ist die Einstellung
  Grafik > Auflösung; voreingestellt ist die Auflösung des Bildschirms.
- Menü und Fenster sind in 1920 × 1080-Einheiten gebaut und werden bei 4K genau doppelt so groß
  gezeichnet. Schrift und Linien bleiben dabei scharf.
- Ganzer Bildschirm: Voreingestellt ist Vollbild. Die Seite wechselt beim ersten Tastendruck oder
  Klick ins Vollbild, weil Browser das nur nach einer Eingabe erlauben. Mit Esc verlässt man es bis
  zum nächsten Laden. Unter Grafik > Fenstermodus lässt sich "Fenster" fest einstellen.
- Schafft die Grafikkarte bei 4K keine 30 Bilder pro Sekunde, zeichnet die Seite den Hintergrund
  etwas kleiner (höchstens bis 70 %). Menü und Schrift bleiben scharf.
- Für Godot: Fenstergröße 3840 × 2160 im Vollbild, Stretch-Modus `canvas_items` mit Basisgröße
  1920 × 1080, dann passen die Maße unten 1:1.

## Was zu sehen ist

- **Hintergrund:** Die Keyart, farblich ans UI angepasst und leise bewegt (WebGL).
  - Farbe ist eingerechnet: weniger Sättigung, weiche Lichter statt HDR-Glühen,
    Schatten zum Petrol des UI, Dunst in der Ferne, dunklerer Vordergrund, Nachtseite rechts
    hinter dem Menü. Held und Pip bleiben wie im Original.
  - Wasserfälle: Nur das Wasser innerhalb des genauen Umrisses bewegt sich. Streifen laufen
    nach unten und werden schneller, Fels und Brücke daneben bleiben stehen. Am Fuß quillt Dunst.
  - Lavafälle fließen langsamer und glühen leise, darüber flimmert die Luft
  - Wolken ziehen ganz langsam mit dem Wind (höchstens etwa 1,5 px pro Sekunde) und behalten
    dabei ihre Form: kein Wabern, kein Quellen. Alle ziehen in dieselbe Richtung, oben etwas
    schneller als am Horizont, auch die großen Wolken um das Wesen.
  - Wie weit sich ein Pixel verschieben darf, hängt vom Abstand zum nächsten festen Element ab
    (Horizont, Burgen, Held, Pip, Drachenkopf, Sichel). So wird nichts Festes mitgezogen.
    Runenbogen, Linien und Rauten liegen als eigene Lichtebene über den Wolken: Die Wolken ziehen
    dahinter durch, das Licht bleibt stehen.
  - der See kräuselt sich, Pflanzen im Vordergrund wiegen sich im Wind
  - Pip schwebt und kippt leicht, Auge und Kern leuchten
  - der Drache bewegt sich kaum merklich, sein Auge glimmt
  - leise Lichtimpulse auf dem Runenbogen und den senkrechten Linien
  - Nebel treibt durchs Tal, die Lichter der Städte flackern kaum merklich
  - etwas Glut über der Lavastadt, ab und zu Vögel
  - die Kamera fährt langsam und folgt leicht der Maus (rechter Stick am Controller)
  - bewusst weggelassen: Sonnenstrahlen, Funken, Staub und starkes Leuchten
- **Intro:** Die Szene taucht aus dem Dunkel auf, die Lichter gehen nacheinander an.
  Die Schiene zeichnet sich von oben nach unten, die Menüpunkte schärfen sich nacheinander ein.
- **Menü rechts**, Titel kommt später (Platz rechts oben bleibt frei, siehe unten):
  Fortsetzen (mit Ort und Spielzeit), Neues Spiel, Spiel laden, Einstellungen, Mitwirkende, Beenden.
  Der gewählte Punkt bekommt Lichtfläche, Eckklammern und den Kupferbalken auf der Schiene;
  darunter steht eine kurze Beschreibung.
- **Unterseiten** werden wie das Inventar projiziert (Punkt, Linie, Fenster), und zwar
  aus dem gewählten Menüpunkt heraus. Der Hintergrund wird dabei weich und dunkel.
  - Einstellungen mit den Reitern Spiel, Grafik, Audio, Steuerung (Lautstärke,
    Fenstermodus, Tastenbelegung mit Tausch bei Doppelbelegung, Helligkeit mit Prüfzeichen)
  - Spiel laden mit drei Plätzen
  - Mitwirkende als Abspann (Platzhaltertexte)
  - Abfragen für Neues Spiel und Beenden
- **Übergänge:** Beim Start fliegt das Menü hinaus, die Kamera taucht ins Tal, das Bild wird hell
  und dann schwarz. Danach folgt ein Platzhalter für den Ladebildschirm (Aufgabe 2).
  Beenden schaltet das Bild ab wie einen Projektor.
- **Leerlauf:** Nach 32 Sekunden ohne Eingabe tritt das Menü zurück und die Keyart steht allein.
  Jede Taste holt es zurück.
- **Klang:** Leise Menüklänge, Wind und eine ruhige Fläche. Alles wird im Browser erzeugt,
  es gibt keine Audiodateien. Der Klang startet mit der ersten Taste oder dem ersten Klick.

## Bedienung

| Aktion | Tastatur | Controller | Maus |
|---|---|---|---|
| Auswählen | ↑ ↓ oder W S | Steuerkreuz, linker Stick | zeigen |
| Bestätigen | Enter, Leertaste | A | klicken |
| Zurück | Esc | B | × im Fenster |
| Wert ändern | ← → oder A D | Steuerkreuz links/rechts | klicken, Regler ziehen |
| Reiter wechseln | Q E | LB RB | Reiter klicken |

Die Hinweise unten rechts wechseln zwischen Tastatur und Controller, je nachdem, was zuletzt benutzt wurde.

## Zustände zum Ansehen

- `index.html` : mit Spielstand (Fortsetzen ist der erste Punkt)
- `index.html#neu` : erster Start ohne Spielstand (erster Punkt ist "Spiel starten")
- `index.html#masken` : zeigt farbig, welche Bildbereiche wie bewegt werden (zum Nachjustieren)

Einstellungen werden im Browser gespeichert (localStorage). "Bewegung reduzieren" und "Auflösung"
wirken sofort, und das System-Setting "Bewegung reduzieren" wird beim ersten Start übernommen.
Ohne WebGL zeigt die Seite die Keyart mit einer langsamen Kamerafahrt.

## Maße (in 1920 × 1080-Einheiten, bei 4K alles × 2)

| Element | Position |
|---|---|
| Schiene | x 1428, y 112 bis 992 |
| Titelplatz (leer, `#titleSlot`) | x 1468 bis 1860, y 118 bis 350 |
| Menü | ab x 1429, y 384, Breite 432; Hauptpunkt 94 px hoch, sonst 64 px |
| Beschreibung | unter dem Menü, Breite 372 |
| Hinweise | unten rechts, 56 px Rand |
| Einstellungen | 1260 × 788, mittig |
| Spiel laden | 1080 × 700, mittig |

Die rechte Spalte hängt am rechten Rand, die Version am linken, Fenster sitzen in der Mitte.
So bleibt das Menü auch bei 21:9 rechts.

## Schnittstelle für Godot (`ui/main_menu/`)

Das Mockup meldet dieselben Ereignisse, die die Szene später als Signale hat
(in der Browser-Konsole und als `hollental:<signal>`-Event):

| Signal | Wann |
|---|---|
| `continue_pressed` | Fortsetzen |
| `new_game_pressed(slot: int)` | Neues Spiel oder Spiel starten, mit Platz |
| `load_game_pressed(slot: int)` | Spielstand im Laden-Fenster gewählt |
| `options_pressed` | Einstellungen geöffnet |
| `credits_pressed` | Mitwirkende geöffnet |
| `quit_pressed` | Beenden bestätigt |
| `setting_changed(key: String, value)` | ein Wert in den Einstellungen geändert |

`new_game_pressed`, `continue_pressed`, `options_pressed` und `quit_pressed` stehen so in
`docs/aufgaben.md`. `load_game_pressed`, `credits_pressed` und `setting_changed` sind neu dazugekommen.

Für die Umsetzung in Godot:

- Hintergrund: Im Spiel ersetzt eine echte Szene oder die Keyart mit einem Shader den WebGL-Teil.
  Die Bereiche (Masken) sind im Code als Polygone beschrieben (`SH`, `FALLS`, `LAVA` usw.)
  und lassen sich als Maskentextur exportieren oder neu malen. Die Umrisse von Held und Pip
  sind aus den Kanten im Bild abgeleitet, die Beine nachgezeichnet.
- Farbabstimmung: Sie ist fest ins eingebettete Bild gerechnet. Die Werte stehen auch so im Code
  (Sättigung etwa 0,6 bis 0,85, Lichter ab 0,56 weich abgerollt, Schatten zu `#0e161d`, Lichter
  leicht kupfern, rechts bis zu 30 % dunkler) und lassen sich in Godot als Color-Grading übernehmen.
- Menüpunkte: `Button` mit eigenem Theme-Stil; Lichtfläche, Eckklammern und Kupferbalken als
  ein gemeinsamer Cursor, der per `Tween` zum fokussierten Punkt fährt.
- Fokus: Hover setzt den Fokus, wie bei Tastatur und Controller.
- Fenster: Projektion als `Tween` auf `scale` (erst x, dann y) mit kurzem Flackern über `modulate`.

## Offen

- Titel/Logo und seine Animation
- Musik und echte Klänge
- Sprache: der Wähler ist da, Texte gibt es nur auf Deutsch
- Inhalte der Mitwirkenden
