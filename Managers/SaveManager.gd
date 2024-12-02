extends Node

func load_game() -> Dictionary:
	return {
		"world": "vyrka",
		"player": {
			"type": "human",
			"position": Vector2(100, 125),
			"stats": {
				"health": 100
			}
		}
	}
