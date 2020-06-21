extends Area2D

var selected = false
var clicked = false

onready var animation = $AnimationPlayer

func _ready():
  connect("mouse_exited", self, "_on_mouse_exited")
  connect("input_event", self, "_on_input_event")

func _on_mouse_exited():
  clicked = false
  animation.play("Idle")

func _on_input_event(_viewport, event, _shape_id):
  if event is InputEventMouseButton:
    if event.button_index == BUTTON_LEFT:
      if event.pressed:
        clicked = true
        animation.play("Click")
      if !event.pressed && clicked:
        animation.play("Idle")
        clicked = false
        print("clicked done")