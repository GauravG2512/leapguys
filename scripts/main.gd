extends Node3D

const SAVE_PATH: String = "user://leapguys_progress.cfg"
const PLATFORM_SCENE: PackedScene = preload("res://objects/platform.tscn")
const MEDIUM_PLATFORM_SCENE: PackedScene = preload("res://objects/platform_medium.tscn")
const ROUND_PLATFORM_SCENE: PackedScene = preload("res://objects/platform_grass_large_round.tscn")
const LARGE_PLATFORM_SCENE: PackedScene = preload("res://objects/platform_large.tscn")
const FALLING_PLATFORM_SCENE: PackedScene = preload("res://objects/platform_falling.tscn")
const COIN_SCENE: PackedScene = preload("res://objects/coin.tscn")
const FLAG_SCENE: PackedScene = preload("res://models/flag.glb")
const CLOUD_SCENE: PackedScene = preload("res://objects/cloud.tscn")
const THANK_YOU_TEXTURE: Texture2D = preload("res://thank-you.png")

# Platform routes are purpose-built per level. Coordinates are center points.
# Every course contains circular grass platforms; all meshes are existing game assets.
const LEVELS: Array[Dictionary] = [
	{
		"name": "LEVEL 1 — GARDEN RUN",
		"hint": "Basic jumps only. Learn to read the platforms and reach the flag.",
		"max_jumps": 1,
		"points": [
			Vector3(0, 0, 0), Vector3(-4.3, 0, 0), Vector3(-8.0, 0.1, 0),
			Vector3(-8.0, 0.1, -3.5), Vector3(-8.0, 0.2, -7.8),
			Vector3(-3.7, 0.25, -7.8), Vector3(-3.7, 0.3, -11.5),
			Vector3(0.5, 0.35, -11.5), Vector3(4.8, 0.4, -11.5),
			Vector3(9.1, 0.45, -11.5)
		],
		"types": ["large", "standard", "medium", "standard", "round", "medium", "standard", "round", "medium", "large"],
		"coins": [1, 3, 5, 8],
		"double_gaps": [], "triple_gaps": [], "moving": [], "falling": [],
		"checkpoints": [4]
	},
	{
		"name": "LEVEL 2 — DOUBLE / TRIPLE LEAP",
		"hint": "Use repeated mid-air jumps to cross the canyon gaps.",
		"max_jumps": 3,
		"points": [
			Vector3(0, 0, 0), Vector3(-4.3, 0, 0), Vector3(-8.5, 0.1, 0),
			Vector3(-13.3, 0.6, 0), Vector3(-13.3, 0.7, -4.2),
			Vector3(-13.3, 0.8, -8.3), Vector3(-9.0, 0.9, -8.3),
			Vector3(-4.2, 1.5, -8.3), Vector3(-4.2, 1.5, -12.0),
			Vector3(0.1, 1.8, -12.0), Vector3(4.3, 1.8, -12.0),
			Vector3(9.1, 2.1, -12.0), Vector3(13.4, 2.1, -12.0)
		],
		"types": ["large", "standard", "standard", "standard", "round", "standard", "medium", "standard", "standard", "round", "standard", "standard", "large"],
		"coins": [1, 5, 8, 10],
		"double_gaps": [2], "triple_gaps": [3, 7, 11], "moving": [], "falling": [],
		"checkpoints": [4]
	},
	{
		"name": "LEVEL 3 — DRIFTING SWITCHBACKS",
		"hint": "A rising S-route across subtly moving platforms. Keep your momentum.",
		"max_jumps": 3,
		"points": [
			Vector3(0, 0, 0), Vector3(-4.3, 0, 0), Vector3(-8.6, 0.3, 0),
			Vector3(-8.6, 0.5, -4.5), Vector3(-8.6, 0.7, -8.8),
			Vector3(-4.3, 1.0, -8.8), Vector3(0, 1.2, -8.8),
			Vector3(4.3, 1.5, -8.8), Vector3(8.6, 1.8, -8.8),
			Vector3(8.6, 2.1, -13.5), Vector3(4.3, 2.4, -13.5),
			Vector3(-0.2, 2.7, -13.5), Vector3(-4.5, 3.0, -13.5)
		],
		"types": ["large", "standard", "round", "medium", "standard", "medium", "round", "standard", "medium", "medium", "round", "standard", "large"],
		"coins": [0, 10],
		"double_gaps": [], "triple_gaps": [], "moving": [1, 2, 3, 4, 5, 7, 8, 9, 11], "falling": [],
		"checkpoints": [6]
	},
	{
		"name": "LEVEL 4 — FALLING TRAIL",
		"hint": "Keep moving: the marked trail platforms collapse after you land.",
		"max_jumps": 3,
		"points": [
			Vector3(0, 0, 0), Vector3(-4.3, 0, 0), Vector3(-4.3, 0, -4.3),
			Vector3(-8.6, 0.5, -4.3), Vector3(-12.9, 0.8, -4.3),
			Vector3(-12.9, 1.0, -8.6), Vector3(-8.6, 1.2, -8.6),
			Vector3(-8.6, 1.6, -12.9), Vector3(-4.3, 1.9, -12.9),
			Vector3(0, 2.2, -12.9), Vector3(0, 2.5, -17.5),
			Vector3(4.4, 2.8, -17.5), Vector3(4.4, 3.1, -22.0),
			Vector3(8.8, 3.4, -22.0)
		],
		"types": ["large", "medium", "falling", "standard", "falling", "standard", "round", "falling", "medium", "falling", "round", "standard", "falling", "large"],
		"coins": [1, 5, 8, 11],
		"double_gaps": [], "triple_gaps": [], "moving": [], "falling": [2, 4, 7, 9, 12],
		"checkpoints": [6]
	},
	{
		"name": "LEVEL 5 — SKY RUINS",
		"hint": "The longest course: triple jumps, moving tiles, falling platforms and two checkpoints.",
		"max_jumps": 3,
		"points": [
			Vector3(0, 0, 0), Vector3(-4.3, 0, 0), Vector3(-8.6, 0.1, 0),
			Vector3(-8.6, 0.3, -4.3), Vector3(-8.6, 0.5, -9.1),
			Vector3(-4.3, 0.8, -9.1), Vector3(0, 1.0, -9.1),
			Vector3(0, 1.2, -13.4), Vector3(4.3, 1.4, -13.4),
			Vector3(9.1, 1.7, -13.4), Vector3(9.1, 2.0, -18.2),
			Vector3(4.3, 2.3, -18.2), Vector3(0, 2.6, -18.2),
			Vector3(0, 2.9, -23.0), Vector3(-4.3, 3.2, -23.0),
			Vector3(-8.6, 3.5, -23.0), Vector3(-12.9, 3.8, -23.0),
			Vector3(-12.9, 4.1, -27.8), Vector3(-8.1, 4.4, -27.8),
			Vector3(-3.8, 4.7, -27.8), Vector3(0.7, 5.0, -27.8)
		],
		"types": ["large", "standard", "round", "standard", "falling", "medium", "standard", "round", "medium", "falling", "round", "standard", "medium", "falling", "round", "standard", "large", "falling", "standard", "medium", "round"],
		"coins": [1, 2, 6, 10, 12, 16],
		"double_gaps": [2], "triple_gaps": [4, 9, 13, 17],
		"moving": [3, 5, 8, 11, 15, 18, 19], "falling": [4, 9, 13, 17],
		"checkpoints": [7, 14]
	}
]

var current_level: int = 1
var level_finished: bool = false
var level_coins: int = 0
var total_coins: int = 0
var checkpoint_position: Vector3 = Vector3.ZERO
var moving_platforms: Array[Dictionary] = []
var level_label: Label
var overlay: ColorRect
var overlay_title: Label
var overlay_body: Label
var action_button: Button
var ending_screen: TextureRect

func _ready() -> void:
	if RenderingServer.get_current_rendering_method() == "gl_compatibility":
		$Sun.light_energy = 0.24
		$Sun.shadow_opacity = 0.85
		$Environment.environment.background_energy_multiplier = 0.25
	_setup_hud()
	if not $Player.coin_collected.is_connected(_on_coin_collected):
		$Player.coin_collected.connect(_on_coin_collected)
	_build_level(current_level)

func _physics_process(_delta: float) -> void:
	var time: float = float(Time.get_ticks_msec()) / 1000.0
	for entry in moving_platforms:
		var platform: Node3D = entry["node"]
		if is_instance_valid(platform):
			var origin: Vector3 = entry["origin"]
			var phase: float = entry["phase"]
			var speed: float = entry["speed"]
			var amplitude: Vector3 = entry["amplitude"]
			platform.position = origin + Vector3(
				sin(time * speed + phase) * amplitude.x,
				sin(time * speed * 0.72 + phase) * amplitude.y,
				cos(time * speed * 0.83 + phase) * amplitude.z
			)

func _setup_hud() -> void:
	var hud: Control = $HUD
	hud.mouse_filter = Control.MOUSE_FILTER_IGNORE

	level_label = Label.new()
	level_label.position = Vector2(28, 20)
	level_label.add_theme_font_size_override("font_size", 27)
	level_label.add_theme_color_override("font_color", Color(1.0, 0.86, 0.22))
	level_label.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.8))
	level_label.add_theme_constant_override("shadow_offset_x", 2)
	level_label.add_theme_constant_override("shadow_offset_y", 2)
	hud.add_child(level_label)

	var restart_button: Button = Button.new()
	restart_button.text = "RESTART LEVEL (R)"
	restart_button.position = Vector2(28, 650)
	restart_button.custom_minimum_size = Vector2(190, 42)
	restart_button.mouse_filter = Control.MOUSE_FILTER_STOP
	restart_button.pressed.connect(restart_level)
	hud.add_child(restart_button)

	overlay = ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.04, 0.08, 0.88)
	overlay.visible = false
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	hud.add_child(overlay)

	var panel: VBoxContainer = VBoxContainer.new()
	panel.set_anchors_preset(Control.PRESET_CENTER)
	panel.position = Vector2(-260, -140)
	panel.size = Vector2(520, 280)
	panel.add_theme_constant_override("separation", 18)
	overlay.add_child(panel)

	overlay_title = Label.new()
	overlay_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	overlay_title.add_theme_font_size_override("font_size", 40)
	overlay_title.add_theme_color_override("font_color", Color(1.0, 0.83, 0.25))
	panel.add_child(overlay_title)

	overlay_body = Label.new()
	overlay_body.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	overlay_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	overlay_body.add_theme_font_size_override("font_size", 21)
	overlay_body.add_theme_color_override("font_color", Color.WHITE)
	panel.add_child(overlay_body)

	action_button = Button.new()
	action_button.custom_minimum_size = Vector2(250, 58)
	action_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	action_button.add_theme_font_size_override("font_size", 22)
	action_button.pressed.connect(_on_action_pressed)
	panel.add_child(action_button)

	ending_screen = TextureRect.new()
	ending_screen.texture = THANK_YOU_TEXTURE
	ending_screen.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	ending_screen.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	ending_screen.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	ending_screen.visible = false
	ending_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	hud.add_child(ending_screen)

func _build_level(level_number: int) -> void:
	level_finished = false
	overlay.visible = false
	ending_screen.visible = false
	level_coins = 0
	moving_platforms.clear()

	var world: Node3D = $World
	for child in world.get_children():
		world.remove_child(child)
		child.queue_free()

	var data: Dictionary = LEVELS[level_number - 1]
	var points: Array = data["points"]
	var checkpoint_indices: Array = data.get("checkpoints", [])
	checkpoint_position = points[0] + Vector3.UP * 0.8
	$Player.global_position = checkpoint_position
	$Player.velocity = Vector3.ZERO
	$Player.gravity = 0
	$Player.max_jumps = int(data.get("max_jumps", 2))
	$Player.jump_count = 0
	$Player.jump_single = true
	$Player.jump_double = true

	for i in range(points.size()):
		var point: Vector3 = points[i]
		var type_name: String = str(data["types"][i])
		var platform: Node3D
		var is_checkpoint: bool = i in checkpoint_indices
		var is_safe_platform: bool = i == 0 or is_checkpoint or i == points.size() - 1

		# Checkpoints always use the original circular grass platform and never move/fall.
		if is_checkpoint:
			platform = ROUND_PLATFORM_SCENE.instantiate()
		elif i in data["falling"] and not is_safe_platform:
			platform = FALLING_PLATFORM_SCENE.instantiate()
		else:
			match type_name:
				"round":
					platform = ROUND_PLATFORM_SCENE.instantiate()
				"large":
					platform = LARGE_PLATFORM_SCENE.instantiate()
				"medium":
					platform = MEDIUM_PLATFORM_SCENE.instantiate()
				"falling":
					platform = FALLING_PLATFORM_SCENE.instantiate()
				_:
					platform = PLATFORM_SCENE.instantiate()

		platform.position = point
		if i in data["moving"] and not is_safe_platform and not (i in data["falling"]):
			moving_platforms.append({
				"node": platform,
				"origin": point,
				"phase": float(i) * 0.83,
				"speed": 0.85 + float(level_number) * 0.08,
				"amplitude": Vector3(0.16, 0.14, 0.16)
			})
		world.add_child(platform)

		if i in data["coins"] and not is_checkpoint and i != points.size() - 1 and not (i in data["moving"]) and not (i in data["falling"]):
			var coin: Node3D = COIN_SCENE.instantiate()
			coin.position = point + Vector3.UP * 1.1
			world.add_child(coin)

		if is_checkpoint:
			_add_checkpoint(point)

	_add_finish(points[points.size() - 1])
	_add_clouds(points)
	level_label.text = "LEAPGUYS  /  " + str(data["name"])

func _add_checkpoint(point: Vector3) -> void:
	var area: Area3D = Area3D.new()
	area.name = "CheckpointTrigger"
	area.position = point + Vector3.UP * 0.85
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: SphereShape3D = SphereShape3D.new()
	shape.radius = 1.55
	collision.shape = shape
	area.add_child(collision)
	area.body_entered.connect(_on_checkpoint_entered.bind(point + Vector3.UP * 0.8))
	$World.add_child(area)

	var flag: Node3D = FLAG_SCENE.instantiate()
	flag.name = "CheckpointFlag"
	flag.position = point + Vector3.UP * 0.45
	flag.scale = Vector3(0.8, 0.8, 0.8)
	$World.add_child(flag)

func _add_finish(point: Vector3) -> void:
	var goal: Area3D = Area3D.new()
	goal.name = "LevelFinish"
	goal.position = point + Vector3.UP * 0.72
	var flag: Node3D = FLAG_SCENE.instantiate()
	flag.name = "FinishFlag"
	flag.position.y = -0.22
	flag.scale = Vector3(1.15, 1.15, 1.15)
	goal.add_child(flag)
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: SphereShape3D = SphereShape3D.new()
	shape.radius = 1.3
	collision.shape = shape
	goal.add_child(collision)
	goal.body_entered.connect(_on_goal_entered)
	$World.add_child(goal)

func _add_clouds(points: Array) -> void:
	for i in range(2, points.size(), 4):
		var cloud: Node3D = CLOUD_SCENE.instantiate()
		cloud.position = points[i] + Vector3(3.5, 4.5, 3.5)
		cloud.scale = Vector3.ONE * 1.2
		$World.add_child(cloud)

func _on_coin_collected(coins: int) -> void:
	total_coins = coins
	level_coins += 1

func _on_checkpoint_entered(body: Node3D, saved_position: Vector3) -> void:
	if body == $Player:
		checkpoint_position = saved_position

func _on_goal_entered(body: Node3D) -> void:
	if body != $Player or level_finished:
		return
	level_finished = true
	$Player.velocity = Vector3.ZERO
	if current_level < LEVELS.size():
		overlay_title.text = "LEVEL COMPLETE!"
		overlay_body.text = "Great job! Coins collected this level: %d. Get ready for the next challenge." % level_coins
		action_button.text = "START LEVEL %d  →" % (current_level + 1)
		overlay.visible = true
	else:
		ending_screen.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_action_pressed() -> void:
	if level_finished and current_level < LEVELS.size():
		current_level += 1
	elif current_level >= LEVELS.size():
		current_level = 1
		total_coins = 0
		$Player.coins = 0
	_build_level(current_level)

func restart_level() -> void:
	_build_level(current_level)

func handle_player_fall() -> void:
	$Player.global_position = checkpoint_position
	$Player.velocity = Vector3.ZERO
	$Player.movement_velocity = Vector3.ZERO
	$Player.gravity = 0
	$Player.jump_count = 0
	$Player.jump_single = true
	$Player.jump_double = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_R:
			restart_level()
		elif event.keycode == KEY_ENTER and ending_screen.visible:
			current_level = 1
			total_coins = 0
			$Player.coins = 0
			_build_level(current_level)
