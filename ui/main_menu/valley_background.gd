extends Control
## Prozedural gezeichneter Hintergrund: Nachthimmel, Mond, Bergketten, Nebel, Gluehwuermchen.
## Rein per Code, skaliert mit der Fenstergroesse; keine Assets noetig.

const SKY_STOPS: Array[float] = [0.0, 0.4, 0.7, 1.0]
const SKY_COLORS: Array[Color] = [
	Color("050810"), Color("0e1b26"), Color("1f3a3c"), Color("3a5a50"),
]
const RIDGES: Array[Dictionary] = [
	{"base": 0.62, "amp": 0.10, "freq": 3.0, "seed": 1.3, "color": Color("1a2f33")},
	{"base": 0.72, "amp": 0.09, "freq": 4.5, "seed": 4.1, "color": Color("12232a")},
	{"base": 0.84, "amp": 0.07, "freq": 6.0, "seed": 7.7, "color": Color("0b161b")},
	{"base": 0.93, "amp": 0.05, "freq": 8.0, "seed": 2.9, "color": Color("050a0d")},
]
const RIDGE_STEPS := 64
const STAR_COUNT := 90
const FIREFLY_COUNT := 24
const TREE_RIDGE := 3

var _time := 0.0
var _stars: Array[Vector3] = []     # x, y (0..1), Phase
var _fireflies: Array[Vector3] = [] # x, y (0..1), Phase
var _trees: Array[Vector2] = []     # x (0..1), Hoehe (0..1 relativ)
var _fog: Array[Dictionary] = []


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	var rng := RandomNumberGenerator.new()
	rng.seed = 1337
	for i in STAR_COUNT:
		_stars.append(Vector3(rng.randf(), rng.randf() * 0.5, rng.randf() * TAU))
	for i in FIREFLY_COUNT:
		_fireflies.append(Vector3(rng.randf(), rng.randf_range(0.6, 0.95), rng.randf() * TAU))
	for i in 46:
		_trees.append(Vector2(rng.randf(), rng.randf_range(0.6, 1.0)))
	for i in 5:
		_fog.append({
			"x": rng.randf(), "y": rng.randf_range(0.6, 0.9),
			"speed": rng.randf_range(0.004, 0.012), "w": rng.randf_range(0.18, 0.32),
		})


func _process(delta: float) -> void:
	_time += delta
	queue_redraw()


func _ridge_height(ridge: Dictionary, x: float) -> float:
	var f: float = ridge["freq"]
	var s: float = ridge["seed"]
	var n := sin(x * f + s) * 0.5 + sin(x * f * 2.3 + s * 1.7) * 0.3 + sin(x * f * 4.1 + s * 2.3) * 0.2
	return (float(ridge["base"]) + float(ridge["amp"]) * n) * size.y


func _draw() -> void:
	_draw_sky()
	_draw_moon()
	for i in RIDGES.size():
		_draw_ridge(RIDGES[i])
		if i == 1 or i == 2:
			_draw_fog(i)
	_draw_trees(RIDGES[TREE_RIDGE])
	_draw_fireflies()
	_draw_menu_shade()


func _draw_sky() -> void:
	for i in SKY_STOPS.size() - 1:
		var y0 := SKY_STOPS[i] * size.y
		var y1 := SKY_STOPS[i + 1] * size.y
		draw_polygon(
			PackedVector2Array([Vector2(0, y0), Vector2(size.x, y0), Vector2(size.x, y1), Vector2(0, y1)]),
			PackedColorArray([SKY_COLORS[i], SKY_COLORS[i], SKY_COLORS[i + 1], SKY_COLORS[i + 1]])
		)
	for star in _stars:
		var twinkle := 0.5 + 0.5 * sin(_time * 1.2 + star.z)
		draw_circle(Vector2(star.x * size.x, star.y * size.y), 1.2, Color(0.9, 0.9, 0.8, 0.25 + 0.5 * twinkle))


func _draw_moon() -> void:
	var center := Vector2(size.x * 0.74, size.y * 0.24)
	var radius := maxf(size.y * 0.055, 18.0)
	for i in 8:
		draw_circle(center, radius * (1.0 + i * 0.55), Color(0.85, 0.9, 0.8, 0.025))
	draw_circle(center, radius, Color("e6e2c8"))
	draw_circle(center + Vector2(radius * 0.3, -radius * 0.15), radius * 0.85, Color(0.80, 0.80, 0.70, 0.35))


func _draw_ridge(ridge: Dictionary) -> void:
	var pts := PackedVector2Array()
	for i in RIDGE_STEPS + 1:
		var t := float(i) / RIDGE_STEPS
		pts.append(Vector2(t * size.x, _ridge_height(ridge, t)))
	pts.append(Vector2(size.x, size.y))
	pts.append(Vector2(0, size.y))
	draw_colored_polygon(pts, ridge["color"])


func _draw_fog(layer: int) -> void:
	for blob in _fog:
		var x := fposmod(float(blob["x"]) + _time * float(blob["speed"]) * (1.0 + layer * 0.3), 1.5) - 0.25
		var pos := Vector2(x * size.x, float(blob["y"]) * size.y)
		draw_set_transform(pos, 0.0, Vector2(1.0, 0.16))
		var r := float(blob["w"]) * size.x
		for i in 6:
			draw_circle(Vector2.ZERO, r * (1.0 - i * 0.14), Color(0.55, 0.70, 0.68, 0.018))
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)


func _draw_trees(ridge: Dictionary) -> void:
	for tree in _trees:
		var base := Vector2(tree.x * size.x, _ridge_height(ridge, tree.x) + 4.0)
		var h := size.y * 0.07 * tree.y
		var w := h * 0.38
		draw_colored_polygon(
			PackedVector2Array([base + Vector2(-w, 0), base + Vector2(0, -h), base + Vector2(w, 0)]),
			Color("03070a")
		)


func _draw_fireflies() -> void:
	for fly in _fireflies:
		var pos := Vector2(
			(fly.x + sin(_time * 0.3 + fly.z) * 0.02) * size.x,
			(fly.y + cos(_time * 0.25 + fly.z * 1.3) * 0.015) * size.y
		)
		var glow := maxf(0.0, sin(_time * 0.9 + fly.z * 3.0))
		draw_circle(pos, 9.0, Color(0.94, 0.77, 0.42, 0.06 * glow))
		draw_circle(pos, 4.0, Color(0.94, 0.77, 0.42, 0.25 * glow))
		draw_circle(pos, 1.6, Color(1.0, 0.95, 0.7, 0.9 * glow))


## Dunkelt die linke Seite ab, damit Titel und Menue gut lesbar bleiben.
func _draw_menu_shade() -> void:
	var edge := size.x * 0.6
	var dark := Color(0.02, 0.04, 0.05, 0.7)
	var clear := Color(0.02, 0.04, 0.05, 0.0)
	draw_polygon(
		PackedVector2Array([Vector2.ZERO, Vector2(edge, 0), Vector2(edge, size.y), Vector2(0, size.y)]),
		PackedColorArray([dark, clear, clear, dark])
	)
