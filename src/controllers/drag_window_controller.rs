use druid::widget::Controller;
use druid::{Env, Event, EventCtx, Widget};

pub struct DragWindowController;

impl<T, W: Widget<T>> Controller<T, W> for DragWindowController {
    fn event(&mut self, child: &mut W, ctx: &mut EventCtx, event: &Event, data: &mut T, env: &Env) {
        if let Event::MouseMove(_) = event {
            ctx.window().handle_titlebar(true);
        }

        child.event(ctx, event, data, env);
    }
}
