extends Node


var ins_enemy = preload("res://res/scene/enemy.tscn")
onready var node_score = get_node("lbl_score")

func _process(delta):

	if int(randf() * 5) == 1:
		var o_enemy = ins_enemy.instance()

		o_enemy.vctDir.z = 0.1 + randf()
		o_enemy.power = 1 + int(randf() * 3)

		o_enemy.set_translation(
			Vector3(
				10 - randf() * 20,
				5 - randf() * 10,
				-50
			)
		)

		self.add_child(o_enemy)

	# score
	node_score.set_text(str(system.score))

func _ready():
	set_process(true)



# [EOF]
