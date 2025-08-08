use crate::utils::open_browser::open_in_browser;
use druid::{Cursor, Data, Env, Event, EventCtx, Widget, widget::Controller};

pub struct LinkIconController {
    link: String,
}

impl LinkIconController {
    pub fn new(link: &str) -> Self {
        Self {
            link: link.to_string(),
        }
    }
}

impl<T: Data, W: Widget<T>> Controller<T, W> for LinkIconController {
    fn event(&mut self, child: &mut W, ctx: &mut EventCtx, event: &Event, data: &mut T, env: &Env) {
        match event {
            Event::MouseUp(_) => {
                open_in_browser(&self.link);
            }
            Event::MouseMove(_) => {
                ctx.set_cursor(&Cursor::Pointer);
            }
            _ => {}
        }

        child.event(ctx, event, data, env);
    }
}
