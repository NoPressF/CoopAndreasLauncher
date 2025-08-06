use druid::Color;
use druid::widget::BackgroundBrush;

pub enum LauncherColors {
    BackgroundDarkGrey,
    ButtonLightGrey,
}

impl LauncherColors {
    fn to_color(&self) -> Color {
        match self {
            LauncherColors::BackgroundDarkGrey => Color::rgb8(18, 18, 18),
            LauncherColors::ButtonLightGrey => Color::rgb8(215, 215, 215),
        }
    }
}

impl<T> From<LauncherColors> for BackgroundBrush<T> {
    fn from(color: LauncherColors) -> Self {
        BackgroundBrush::Color(color.to_color())
    }
}

impl From<LauncherColors> for druid::Color {
    fn from(color: LauncherColors) -> Self {
        color.to_color()
    }
}