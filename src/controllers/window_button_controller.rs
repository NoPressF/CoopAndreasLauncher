use crate::{launcher_data::LauncherData, widgets::window_button::WindowButtonAction};

use druid::{Cursor, Env, Event, EventCtx, Widget, WindowState, widget::Controller};

pub struct WindowButtonController {
    action: WindowButtonAction,
}

impl WindowButtonController {
    pub fn new(action: WindowButtonAction) -> Self {
        Self { action: action }
    }
}

impl<W: Widget<LauncherData>> Controller<LauncherData, W> for WindowButtonController {
    fn event(
        &mut self,
        child: &mut W,
        ctx: &mut EventCtx,
        event: &Event,
        data: &mut LauncherData,
        env: &Env,
    ) {
        match event {
            Event::MouseUp(_) => match self.action {
                WindowButtonAction::Minimize => {
                    let mut window_handle = ctx.window().clone();
                    window_handle.set_window_state(WindowState::Minimized);
                    data.is_hot_button = false;
                    ctx.set_handled();
                }
                WindowButtonAction::Close => {
                    ctx.window().close();
                    ctx.set_handled();
                }
            },
            Event::MouseMove(_) => {
                ctx.set_cursor(&Cursor::Pointer);
                data.is_hot_button = ctx.is_hot();
                ctx.set_handled();
            }
            _ => {}
        }

        child.event(ctx, event, data, env);
    }
}
