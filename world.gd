extends Node2D

@onready var fog = $Fog
@export var lightWidth = 40
@export var lightHeight = 40

var lightTexture = preload("res://Light.png")
var displayWidth = ProjectSettings.get('display/window/size/viewport_width')
var displayHeight = ProjectSettings.get('display/window/size/viewport_height')
var fogImage: Image
var lightImage: Image
var fogTexture : ImageTexture
var lightOffset = Vector2(lightTexture.get_width() / 2.0, lightTexture.get_height() / 2.0)

func _ready():
	lightImage = lightTexture.get_image()
	lightImage.resize(lightWidth, lightHeight)
	
	var fogImageWidth = displayWidth
	var fogImageHeight = displayHeight
	fogImage = Image.create(fogImageWidth, fogImageHeight, false, Image.FORMAT_RGBA8)
	fogImage.fill(Color.BLACK)
	
	fogTexture = ImageTexture.create_from_image(fogImage)
	fog.texture = fogTexture

func update_fog(pos):
	var lightRect = Rect2(Vector2.ZERO, lightImage.get_size())

	fogImage.blend_rect(lightImage, lightRect, pos - lightOffset)
	fogTexture.update(fogImage)

func _input(event: InputEvent) -> void:
	update_fog(get_local_mouse_position())
