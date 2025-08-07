use druid::Color;
use druid::widget::BackgroundBrush;

pub enum Colors {
    BackgroundDarkGrey,
    BackgroundGrey,
    ButtonLightGrey,
}

impl Colors {
    fn to_color(&self) -> Color {
        match self {
            Colors::BackgroundDarkGrey => Color::rgb8(18, 18, 18),
            Colors::BackgroundGrey => Color::rgb8(26, 26, 26),
            Colors::ButtonLightGrey => Color::rgb8(215, 215, 215),
        }
    }
}

impl<T> From<Colors> for BackgroundBrush<T> {
    fn from(color: Colors) -> Self {
        BackgroundBrush::Color(color.to_color())
    }
}

impl From<Colors> for druid::Color {
    fn from(color: Colors) -> Self {
        color.to_color()
    }
}
