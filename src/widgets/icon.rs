use druid::piet::ImageBuf;
use druid::widget::Image;
use druid::{Data, Widget, WidgetExt, widget::ControllerHost};

use crate::controllers::button_icon_controller::ButtonIconController;

pub struct Icon;

impl Icon {
    pub fn new<T: Data>(icon: &str, link: &str) -> impl Widget<T> {
        let img =
            image::open(format!("assets/icons/{}.png", icon)).expect("Failed to open an image!");
        let buf = ImageBuf::from_dynamic_image(img);

        let image = Image::new(buf).fix_size(32.0, 26.0);

        ControllerHost::new(image, ButtonIconController::new(link))
    }
}
