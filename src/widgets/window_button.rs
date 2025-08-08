use crate::utils::image::load_icon;
use druid::widget::Image;
use druid::{Data, Size, Widget, WidgetExt};

pub enum WindowButtonAction {
    Minimize,
    Close,
}

pub struct WindowButton;

impl WindowButton {
    pub fn new<T: Data>(icon: &str, size: Size) -> impl Widget<T> {
        let buf = load_icon(icon);

        Image::new(buf).fix_size(size.width, size.height)
    }
}
