extends Node
class_name StateMachine

@export_group("State Machine")
@export var initialState : State
@export_group("")

var states: Dictionary = {}
var currentState: State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(_on_child_transition)
	
	if initialState:
		currentState = initialState

func _process(delta):
	if currentState:
		currentState.update(delta)

func _physics_process(delta):
	if currentState:
		currentState.physics_update(delta)

func _on_child_transition(state, new_state_name):
	if state != currentState:
		return
		
	var newState = states.get(new_state_name.to_lower())
	if !newState:
		return
		
	if currentState:
		currentState.exit()
	
	newState.enter()
	
	currentState = newState
