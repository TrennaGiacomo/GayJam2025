extends TextureRect

@export var animAmount: float;
@export var animSpeed: float;

func _ready():
    var tween = get_tree().create_tween();
    tween.tween_property($".", "rotation", animAmount, animSpeed);
    tween.tween_property($".", "rotation", -animAmount, animSpeed);
    tween.set_loops(0);
    tween.play();
    pass