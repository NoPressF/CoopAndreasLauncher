use druid::piet::ImageBuf;
use druid::widget::Image;
use druid::{Data, Widget, WidgetExt, widget::ControllerHost};

use crate::embed::IconAssets;

use crate::controllers::link_icon_controller::LinkIconController;

pub struct LinkIcon;

impl LinkIcon {
    pub fn new<T: Data>(icon: &str, link: &str) -> impl Widget<T> {
        let file_name = format!("{}.png", icon);
        let asset = IconAssets::get(&file_name)
            .expect(&format!("Failed to load embedded icon: {}", file_name));
        let img =
            image::load_from_memory(asset.data.as_ref()).expect("Failed to decode embedded image");
        let buf = ImageBuf::from_dynamic_image(img);

        let image = Image::new(buf).fix_size(32.0, 26.0);

        ControllerHost::new(image, LinkIconController::new(link))
    }
}
