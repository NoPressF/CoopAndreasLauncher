use druid::RenderContext;
use druid::{BoxConstraints, Color, Env, LayoutCtx, PaintCtx, Size, Widget};

use crate::launcher_data::LauncherData;

pub struct Splash {}

impl Splash {
    pub fn new() -> Self {
        Self {}
    }
}

impl Widget<LauncherData> for Splash {
    fn paint(&mut self, ctx: &mut PaintCtx, _data: &LauncherData, _env: &Env) {
        let bounds = ctx.size().to_rounded_rect(25.0);
        ctx.fill(bounds, &Color::rgba8(44, 44, 44, 150));
    }

    fn layout(
        &mut self,
        _ctx: &mut LayoutCtx,
        bc: &BoxConstraints,
        _data: &LauncherData,
        _env: &Env,
    ) -> Size {
        bc.constrain(Size::new(35.0, 35.0))
    }

    fn event(
        &mut self,
        _ctx: &mut druid::EventCtx,
        _event: &druid::Event,
        _data: &mut LauncherData,
        _env: &Env,
    ) {
    }

    fn lifecycle(
        &mut self,
        _ctx: &mut druid::LifeCycleCtx,
        _event: &druid::LifeCycle,
        _data: &LauncherData,
        _env: &Env,
    ) {
    }

    fn update(
        &mut self,
        _ctx: &mut druid::UpdateCtx,
        _old_data: &LauncherData,
        _data: &LauncherData,
        _env: &Env,
    ) {
    }
}
