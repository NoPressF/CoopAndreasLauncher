use crate::utils::open_browser::open_in_browser;
use druid::{Cursor, Data, Env, Event, EventCtx, Widget, widget::Controller};

pub struct ButtonIconController {
    link: String,
}

impl ButtonIconController {
    pub fn new(link: &str) -> Self {
        Self {
            link: link.to_string(),
        }
    }
}

impl<T: Data, W: Widget<T>> Controller<T, W> for ButtonIconController {
    fn event(
        &mut self,
        _child: &mut W,
        ctx: &mut EventCtx,
        event: &Event,
        _data: &mut T,
        _env: &Env,
    ) {
        match event {
            Event::MouseUp(_) => {
                open_in_browser(&self.link);
                ctx.set_handled();
            }
            Event::MouseMove(_) => {
                ctx.set_cursor(&Cursor::Pointer);
            }
            _ => {}
        }
    }
}
