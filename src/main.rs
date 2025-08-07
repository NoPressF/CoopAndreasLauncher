#![windows_subsystem = "console"]

use druid::piet::FontWeight;
use druid::text::{FontDescriptor, FontFamily, FontStyle};
use druid::widget::{Align, Container, Flex, Label};
use druid::{AppLauncher, Screen, UnitPoint, Widget, WidgetExt, WindowDesc};

mod controllers;
mod launcher_data;
mod utils;
mod widgets;

use controllers::drag_controller::DragController;
use launcher_data::LauncherData;
use utils::colors::Colors;
use utils::window_constants::{WINDOW_SIZE, WINDOW_TITLE};
use widgets::icon::Icon;

fn build_ui() -> impl Widget<LauncherData> {
    let font = FontDescriptor {
        family: FontFamily::default(),
        size: 18.0,
        weight: FontWeight::BOLD,
        style: FontStyle::default(),
    };

    let label = Label::new("CoopAndreas").with_font(font);

    let top_bar = Container::new(
        Flex::row()
            .with_child(label)
            .center()
            .controller(DragController),
    )
    .fix_height(60.0)
    .expand_width()
    .background(Colors::BackgroundGrey);

    let row_links = Align::horizontal(
        UnitPoint::BOTTOM_LEFT,
        Flex::row()
            .with_child(Icon::new::<LauncherData>(
                "github_logo",
                "https://github.com/Tornamic/CoopAndreas",
            ))
            .with_spacer(10.0)
            .with_child(Icon::new::<LauncherData>(
                "discord_logo",
                "https://discord.com/invite/TwQsR4qxVx",
            ))
            .padding(8.0),
    );

    let content = Flex::column()
        .with_child(top_bar)
        .with_flex_spacer(1.0)
        .with_child(row_links)
        .background(Colors::BackgroundDarkGrey);

    content
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
