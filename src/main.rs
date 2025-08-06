#![windows_subsystem = "windows"]

use druid::piet::FontWeight;
use druid::text::{FontDescriptor, FontFamily, FontStyle};
use druid::widget::{Container, Flex, Label};
use druid::{AppLauncher, Screen, Widget, WidgetExt, WindowDesc};

mod launcher_data;
mod utils;
mod widgets;

use launcher_data::LauncherData;
use utils::colors::LauncherColors;
use utils::window_constants::{WINDOW_SIZE, WINDOW_TITLE};
use widgets::drag_controller::DragController;

fn build_ui() -> impl Widget<LauncherData> {
    let font = FontDescriptor {
        family: FontFamily::default(),
        size: 18.0,
        weight: FontWeight::BOLD,
        style: FontStyle::default(),
    };

    Container::new(Flex::column().with_child(Label::new("CoopAndreas").with_font(font)))
        .background(LauncherColors::BackgroundDarkGrey)
        .controller(DragController)
}

fn get_center_window_pos() -> (f64, f64) {
    let screen_size = Screen::get_display_rect().size();

    let position = (
        (screen_size.width - WINDOW_SIZE.width) / 2.0,
        (screen_size.height - WINDOW_SIZE.height) / 2.0,
    );

    position
}

fn main() {
    let main_window = WindowDesc::new(build_ui())
        .title(WINDOW_TITLE)
        .window_size(WINDOW_SIZE)
        .resizable(false)
        .set_position(get_center_window_pos())
        .show_titlebar(false);

    AppLauncher::with_window(main_window)
        .log_to_console()
        .launch(LauncherData {})
        .expect("Failed to launch application");
}
