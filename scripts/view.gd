extends Node3D

@export_group("Properties")
@export var target: Node3D

@export_group("Zoom")
@export var zoom_minimum: float = 4.0
@export var zoom_maximum: float = 15.0
@export var zoom_speed: float = 1.0

@export_group("Mouse Look")
@export var mouse_sensitivity: float = 0.16
@export var follow_speed: float = 10.0
@export var rotation_smoothing: float = 14.0

var camera_rotation: Vector3
var zoom: float = 9.0
var mouse_look_active: bool = false

@onready var camera: Camera3D = $Camera

func _ready() -> void:
	camera_rotation = rotation_degrees
	zoom = 9.0
	mouse_look_active = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		return
	global_position = global_position.lerp(target.global_position + Vector3.UP * 0.75, minf(delta * follow_speed, 1.0))
	rotation_degrees = rotation_degrees.lerp(camera_rotation, minf(delta * rotation_smoothing, 1.0))
	camera.position = camera.position.lerp(Vector3(0.0, 0.0, zoom), minf(8.0 * delta, 1.0))

func _input(event: InputEvent) -> void:
	# Drag with RIGHT mouse button to rotate. This uses _input rather than
	# _unhandled_input so the full-screen HUD cannot swallow mouse motion.
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			mouse_look_active = event.pressed
			if mouse_look_active:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom = clampf(zoom - zoom_speed, zoom_minimum, zoom_maximum)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom = clampf(zoom + zoom_speed, zoom_minimum, zoom_maximum)
	elif event is InputEventMouseMotion and mouse_look_active:
		camera_rotation.y -= event.relative.x * mouse_sensitivity
		camera_rotation.x -= event.relative.y * mouse_sensitivity
		camera_rotation.x = clampf(camera_rotation.x, -72.0, -12.0)
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_ESCAPE:
		mouse_look_active = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		mouse_look_active = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
