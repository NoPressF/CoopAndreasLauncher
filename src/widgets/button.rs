use druid::widget::Button;
use druid::widget::Container;
use druid::{Color, Env, EventCtx, Widget, WidgetExt, theme};

use crate::utils::colors::Colors;

#[allow(dead_code)]
fn button<T: druid::Data + 'static>(
    label: &str,
    on_click: impl Fn(&mut EventCtx, &mut T, &Env) + 'static,
) -> impl Widget<T> {
    let button = Button::new(label)
        .on_click(on_click)
        .env_scope(|env: &mut Env, _| {
            env.set(theme::BUTTON_DARK, Colors::ButtonLightGrey);
            env.set(theme::BUTTON_LIGHT, Colors::ButtonLightGrey);
            env.set(theme::TEXT_COLOR, Color::BLACK);
        });

    Container::new(button).rounded(8.0).padding(5.0)
}
