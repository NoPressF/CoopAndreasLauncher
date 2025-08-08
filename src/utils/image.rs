use crate::embed::IconAssets;
use druid::piet::ImageBuf;

pub fn load_icon(icon: &str) -> ImageBuf {
    ImageBuf::from_dynamic_image(
        image::load_from_memory(
            IconAssets::get(&format!("{}.png", icon))
                .unwrap_or_else(|| panic!("Failed to load embedded icon: {}", icon))
                .data
                .as_ref(),
        )
        .unwrap_or_else(|_| panic!("Failed to decode embedded image: {}", icon)),
    )
}
