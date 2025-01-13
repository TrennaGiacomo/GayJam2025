extends Node2D
class_name skilift;

@export var minTime: float;
@export var maxTime: float;

@export var minSize: int;
@export var maxSize: int;

var currentSize: int;
var fillAmount: int;

var waiting: bool;

var timeRemaining: float;

func getNewSkilift():
    currentSize = randi_range(minSize, maxSize);
    timeRemaining = randf_range(minTime, maxTime);

    waiting = true;
    fillAmount = 0;
    pass;

func fill(amount: int):
    if(fillAmount + amount > currentSize):
        return;
    
    fillAmount += amount;
    if(fillAmount == currentSize):
        # Do stuff when the lift is filled
        pass;

    pass;

func _process(delta):
    if(waiting):
        timeRemaining -= delta;
        
        if(timeRemaining < 0):
            waiting = false;
            #Do stuff when time runs out
    pass