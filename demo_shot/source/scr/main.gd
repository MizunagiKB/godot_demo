extends Node


var scene_enemy = preload("res://res/scene/enemy.tscn")
var scene_BG = preload("res://res/scene/bg_wall_01.tscn")
onready var node_score = get_node("lbl_score")

var counter = 0
var list_BG = []


func _process(delta):

	for o_BG in list_BG:
		var vctPos = o_BG.get_translation()
		vctPos.z += 0.5
		if vctPos.z > 8:
			vctPos.z = -8 * 14
		o_BG.set_translation(vctPos)


	if int(randf() * 5) == 1:
		var o_enemy = scene_enemy.instance()

		o_enemy.vctDir.z = 0.1 + randf()
		o_enemy.power = 1 + int(randf() * 3)

		o_enemy.set_translation(
			Vector3(
				10 - randf() * 20,
				0,
				-50
			)
		)

		self.add_child(o_enemy)

	# score
	node_score.set_text(str(system.score))


func _ready():

	for n in range(16):
		var o_BG = scene_BG.instance()
		o_BG.set_translation(Vector3(0, -8, -8 * n))
		o_BG.set_scale(Vector3(1.5, 1, 1))
		list_BG.append(o_BG)

		self.add_child(o_BG)

	set_process(true)



# [EOF]
