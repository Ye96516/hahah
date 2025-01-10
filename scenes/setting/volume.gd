extends HSlider

var sl:SLSystem=SLSystem.new()

func _ready() -> void:
	if sl.has_key("volume"):
		self.value=sl.load_data("volume")

func _on_value_changed(value: float) -> void:
	AudioPlayer.set_volume(0,value)
	sl.save_data("volume",value)
