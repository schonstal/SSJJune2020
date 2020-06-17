extends Node2D

onready var grid = $Grid

var player_moves = 3
var player_control = true

var phase = Game.PHASE_PLAYER

func _ready():
  EventBus.connect("turn_complete", self, "_on_turn_complete")
  EventBus.connect("phase_transition_complete", self, "_on_phase_transition_complete")

func _on_turn_complete():
  if phase == Game.PHASE_PLAYER:
    player_moves -= 1
    if player_moves < 1:
      phase = Game.PHASE_ENEMY
      player_control = false
      EventBus.emit_signal("change_phase", phase)

func _on_phase_transition_complete():
  EventBus.emit_signal("begin_phase", phase)
