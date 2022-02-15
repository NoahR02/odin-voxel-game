package window

import "core:fmt"
import gl "vendor:OpenGL"
import "vendor:glfw"

Window :: struct {

  width:  i32,
  height: i32,
  title:  cstring,

  window_handle: glfw.WindowHandle,

}

create :: proc(width, height: i32, title: cstring, gl_major_version: i32 = 4, gl_minor_version: i32 = 5) -> (window: Window, ok: bool = true) {

  if !bool(glfw.Init()) {
    fmt.println("GLFW has failed to load.")
    ok = false
    return
  }

  glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, gl_major_version)
  glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, gl_minor_version)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  window.window_handle = glfw.CreateWindow(width, height, title, nil, nil)

  using window

  if window_handle == nil {
    fmt.println("GLFW has failed to load the window.")
    ok = false
    return
  }

  glfw.MakeContextCurrent(window_handle)
  gl.load_up_to(int(gl_major_version), int(gl_minor_version), glfw.gl_set_proc_address)

  return window, ok

}

destroy :: proc(using window: ^Window) {
  defer glfw.Terminate()
  defer glfw.DestroyWindow(window_handle)
}

destroy_window_but_keep_glfw_alive :: proc(using window: ^Window) {
  defer glfw.DestroyWindow(window_handle)
}

poll_events :: proc() {
  glfw.PollEvents()
}

swap_buffers :: proc(using window: ^Window) {
  glfw.SwapBuffers(window_handle)
}

should_close :: proc(using window: ^Window) -> b32 {
  return glfw.WindowShouldClose(window_handle)
}

switch_to_rendering_on_this_window :: proc(using window: ^Window) {
  glfw.MakeContextCurrent(window_handle)
}