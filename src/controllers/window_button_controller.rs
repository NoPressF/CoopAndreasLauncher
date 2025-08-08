use crate::widgets::window_button::WindowButtonAction;

use druid::{Cursor, Data, Env, Event, EventCtx, Widget, WindowState, widget::Controller};

pub struct WindowButtonController {
    action: WindowButtonAction,
}

impl WindowButtonController {
    pub fn new(action: WindowButtonAction) -> Self {
        Self { action: action }
    }
}

impl<T: Data, W: Widget<T>> Controller<T, W> for WindowButtonController {
    fn event(&mut self, child: &mut W, ctx: &mut EventCtx, event: &Event, data: &mut T, env: &Env) {
        match event {
            Event::MouseUp(_) => match self.action {
                WindowButtonAction::Minimize => {
                    let mut window_handle = ctx.window().clone();
                    window_handle.set_window_state(WindowState::Minimized);
                    ctx.set_handled();
                }
                WindowButtonAction::Close => {
                    ctx.window().close();
                    ctx.set_handled();
                }
            },
            Event::MouseMove(_) => {
                ctx.set_cursor(&Cursor::Pointer);
                ctx.set_handled();
            }
            _ => {}
        }

        child.event(ctx, event, data, env);
    }
}
