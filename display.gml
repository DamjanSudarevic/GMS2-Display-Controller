#macro DisplayWidth display_get_width()
#macro DisplayHeight display_get_height()
#macro AspectRatio (DisplayWidth / DisplayHeight)

function IOError(exception)
{
	var msg		 = exception.message,
		long_msg = exception.longMessage,
	    stack	 = exception.stacktrace;
		
	show_error("IOError:\n"		  + msg		 +
			   "\nDescription:\n" + long_msg +
			   "\nStack:\n"		  +	stack, true);
}

function Display(_width, _height) constructor
{
	#region Struct variables
	
	w=0; h=0;
	rm=0; min_rm=0; max_rm=0;
	
	scale_gui=true;
	fullscreen=false;
	
	#endregion
	
	#region Resolution and Scaling calculations
	
	w = _width; h = round(w / AspectRatio);
	if (DisplayHeight mod h != 0)
	{ var d = round(DisplayHeight / h); h = DisplayHeight / d; }
	if (h & 1) h ++;
	
	max_rm = floor(DisplayWidth / w);
	for (var i = max_rm; i > 0; i --)
	{ if (h * i < _height) break; min_rm = i; }
	rm = min_rm;
	
	#endregion
	
	#region Accessors
	
	function get_width()
	{ return w*rm }
	
	function get_height()
	{ return h*rm }
	
	function get_min_width()
	{ return w*min_rm }
	
	function get_min_height()
	{ return h*min_rm }
	
	function get_max_width()
	{ return w*max_rm }
	
	function get_max_height()
	{ return h*max_rm }
	
	function get_fullscreen()
	{ return fullscreen }
	
	function toString()
	{ return string(get_width())+"x"+string(get_height()) }
	
	#endregion
	
	#region Resolution Scaling
	
	function apply()
	{
		if window_get_fullscreen() != fullscreen
		{ window_set_fullscreen(fullscreen) }
		var width = get_width(), height = get_height();
		surface_resize(application_surface, width, height);
		window_set_size(width, height);
		if scale_gui { display_set_gui_size(w, h) }
	}
	
	function increment_resolution()
	{ if (++rm > max_rm) rm = min_rm; apply(); }
	
	function decrement_resolution()
	{ if (--rm < min_rm) rm = max_rm; apply(); }
	
	function toggle_fullscreen()
	{ fullscreen=!fullscreen; apply(); }
	
	#endregion
	
	#region Saving and Loading from file
	
	function loadFromFile(fn)
	{
		try {
			var rb = buffer_load(fn);
			rm = buffer_read(rb, buffer_u8);
			scale_gui = buffer_read(rb, buffer_bool);
			fullscreen = buffer_read(rb, buffer_bool);
			buffer_delete(rb);
		} catch (ex) { IOError(ex) }
	}
	
	function saveToFile(fn)
	{
		try {
			var sb = buffer_create(3, buffer_fixed, 1);
			buffer_write(sb, buffer_u8, rm);
			buffer_write(sb, buffer_bool, scale_gui);
			buffer_write(sb, buffer_bool, fullscreen);
			buffer_save(sb, fn); buffer_delete(sb);
		} catch (ex) { IOError(ex) }
	}
	
	#endregion
}