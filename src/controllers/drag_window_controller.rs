use druid::widget::Controller;
use druid::{Env, Event, EventCtx, Widget};

use crate::launcher_data::LauncherData;

pub struct DragWindowController;

impl<W: Widget<LauncherData>> Controller<LauncherData, W> for DragWindowController {
    fn event(
        &mut self,
        child: &mut W,
        ctx: &mut EventCtx,
        event: &Event,
        data: &mut LauncherData,
        env: &Env,
    ) {
        if let Event::MouseMove(_) = event {
            ctx.window().handle_titlebar(!data.is_hot_button);
        }

        child.event(ctx, event, data, env);
    }
}
