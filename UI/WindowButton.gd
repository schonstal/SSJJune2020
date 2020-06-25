extends Area2D

var selected = false
var clicked = false

onready var animation = $AnimationPlayer

var click_sound:AudioStreamPlayer

signal pressed

func _ready():
  connect("mouse_exited", self, "_on_mouse_exited")
  connect("input_event", self, "_on_input_event")
  animation.play("Idle")
  
  click_sound = AudioStreamPlayer.new()
  click_sound.stream = preload("res://sfx/Click_SFX.ogg")
  add_child(click_sound)

func _on_mouse_exited():
  clicked = false
  animation.play("Idle")

func _on_input_event(_viewport, event, _shape_id):
  if event is InputEventMouseButton:
    if event.button_index == BUTTON_LEFT:
      if event.pressed:
        clicked = true
        click_sound.play()
        MusicPlayer.fade("title", 0.5)
        animation.play("Click")
      if !event.pressed && clicked:
        animation.play("Idle")
        clicked = false
        emit_signal("pressed")
