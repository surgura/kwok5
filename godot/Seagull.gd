extends Node2D

export(bool) var isFlying = false
export(bool) var flipHorizontal = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var m_isFlying = false
var m_flipHorizontal = false

func updateState():
	if (isFlying != m_isFlying):
		m_isFlying = isFlying
		get_node("flySprite").visible = isFlying
		get_node("sitSprite").visible = !isFlying
	if (m_flipHorizontal != flipHorizontal):
		m_flipHorizontal = flipHorizontal
		get_node("sitSprite").flip_h = flipHorizontal
		get_node("flySprite").flip_h = flipHorizontal

func _ready():
	updateState()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateState()
