package main

import "core:fmt"
import gl "vendor:OpenGL"

// windowing_system
import ws "window"

main :: proc() {

	window, ok := ws.create(width = 1600, height = 900, title = "odin-voxel-game")
	defer ws.destroy(&window)

	if !ok {
		return
	}

	for !ws.should_close(&window) {
	
		ws.switch_to_rendering_on_this_window(&window)
		ws.poll_events()

		gl.ClearColor(0.1, 0.5, 0.3, 1.0)
		gl.Clear(gl.COLOR_BUFFER_BIT)

		ws.swap_buffers(&window)	

	}

}