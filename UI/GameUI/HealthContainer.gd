extends CenterContainer

@onready var progress_bar: ProgressBar = $ProgressBar;

func set_value(value: int):
	progress_bar.value = clamp(value, 0, 100)
