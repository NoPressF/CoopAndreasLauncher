use druid::widget::Controller;
use druid::{Env, Event, EventCtx, Widget};

pub struct DragController;

impl<T, W: Widget<T>> Controller<T, W> for DragController {
    fn event(
        &mut self,
        _child: &mut W,
        ctx: &mut EventCtx,
        event: &Event,
        _data: &mut T,
        _env: &Env,
    ) {
        if let Event::MouseMove(_) = event {
            ctx.window().handle_titlebar(true);
        }
    }
}
