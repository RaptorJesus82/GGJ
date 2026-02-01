extends Node2D

@onready var light = $PointLight2D
@export var angle = 60.
@export var color:Color
@export var alphaMinAngle:float = 0.
@export var alphaMinRadius:float = 0.
@export var tangToBaseAngle:float = 0.8
@export var tangToBaseRadius:float = 0.006
var decalage = 10

func _ready() -> void:
	var image = light.texture.get_image()
	var newImage = Image.create_empty(512 + 2*decalage, 512, false, Image.FORMAT_RGBA8)
	buildImage(newImage)
	var newTexture = ImageTexture.create_from_image(newImage)
	light.texture = newTexture
	
func buildImage(image:Image) -> void:
	var size = image.get_size()
	var origin = Vector2((size.x - 2*decalage) / 2, size.y / 2)
	var realHalfAngle = angle * PI / 360
	for x in range(decalage, size.x - decalage):
		for y in range(size.y):
			var pixelVector = Vector2(x, y)
			var myVector:Vector2 = pixelVector - origin
			var halfAngle = abs(Vector2.RIGHT.angle_to(myVector))
			if halfAngle < realHalfAngle and myVector.length() < origin.x:
				var alphaAngle = attenuation(alphaMinAngle, realHalfAngle, tangToBaseAngle, halfAngle)
				var alphaRadius = attenuation(alphaMinRadius, origin.x, tangToBaseRadius, myVector.length())
				var alpha = alphaAngle * alphaRadius
				var pixColor = color
				pixColor.a *= alpha
				image.set_pixel(x, y, pixColor)

func attenuation(extrValue, extrIndex, tangToBase, value, baseValue = 1):
	return extrValue + (baseValue - extrValue)*(1 - exp(-tangToBase * (extrIndex - value)))
