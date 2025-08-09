use crate::launcher_data::LauncherData;
use crate::utils::image::load_icon;
use crate::widgets::splash::Splash;
use druid::widget::Image;
use druid::{
    Cursor, Env, Event, EventCtx, LifeCycle, PaintCtx, Point, Size, Widget, WidgetExt, WidgetPod,
    WindowState,
};

pub enum WindowButtonAction {
    Minimize,
    Close,
}

pub struct WindowButton<T> {
    action: WindowButtonAction,
    image: Box<dyn Widget<T>>,
    splash: WidgetPod<T, Splash>,
    size: Size,
}

impl WindowButton<LauncherData> {
    pub fn new(icon: &str, action: WindowButtonAction, size: Size) -> Self {
        let buf = load_icon(icon);

        let image = Image::new(buf).fix_size(size.width, size.height);
        let splash: Splash = Splash::new();

        Self {
            action: action,
            image: Box::new(image),
            splash: WidgetPod::new(splash),
            size: size,
        }
    }
}

impl Widget<LauncherData> for WindowButton<LauncherData> {
    fn event(&mut self, ctx: &mut EventCtx, event: &Event, data: &mut LauncherData, env: &Env) {
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
                ctx.request_paint();
                ctx.set_handled();
            }
            _ => {}
        }

        self.image.event(ctx, event, data, env);
        self.splash.event(ctx, event, data, env);
    }

    fn paint(&mut self, ctx: &mut PaintCtx, data: &LauncherData, env: &Env) {
        if ctx.is_hot() {
            self.splash.paint(ctx, data, env);
        }

        self.image.paint(ctx, data, env);
    }

    fn lifecycle(
        &mut self,
        ctx: &mut druid::LifeCycleCtx,
        event: &druid::LifeCycle,
        data: &LauncherData,
        env: &Env,
    ) {
        match event {
            LifeCycle::HotChanged(_hot) => {
                ctx.request_layout();
            }
            _ => {}
        }

        self.image.lifecycle(ctx, event, data, env);
        self.splash.lifecycle(ctx, event, data, env);
    }

    fn update(
        &mut self,
        ctx: &mut druid::UpdateCtx,
        old_data: &LauncherData,
        data: &LauncherData,
        env: &Env,
    ) {
        self.image.update(ctx, old_data, data, env);
        self.splash.update(ctx, data, env);
    }

    fn layout(
        &mut self,
        ctx: &mut druid::LayoutCtx,
        bc: &druid::BoxConstraints,
        data: &LauncherData,
        env: &Env,
    ) -> druid::Size {
        let size = bc.constrain(self.size);

        let splash_size = self.splash.layout(ctx, &bc, data, env);
        let splash_origin = Point::new(
            (size.width - splash_size.width) / 2.0,
            (size.height - splash_size.height) / 2.0,
        );

        self.splash.set_origin(ctx, splash_origin);

        size
    }
}
