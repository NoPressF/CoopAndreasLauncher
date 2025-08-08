#![windows_subsystem = "console"]

use druid::piet::FontWeight;
use druid::text::{FontDescriptor, FontFamily, FontStyle};
use druid::widget::{Align, Container, CrossAxisAlignment, Flex, Label, SizedBox, ZStack};
use druid::{AppLauncher, Screen, Size, UnitPoint, Vec2, Widget, WidgetExt, WindowDesc};

mod controllers;
mod embed;
mod launcher_data;
mod utils;
mod widgets;

use controllers::drag_window_controller::DragWindowController;
use launcher_data::LauncherData;
use utils::colors::Colors;
use utils::url::{DISCORD_URL, GITHUB_URL};
use utils::window_constants::{WINDOW_SIZE, WINDOW_TITLE};
use widgets::link_icon::LinkIcon;
use widgets::window_button::WindowButton;

use crate::controllers::window_button_controller::WindowButtonController;
use crate::widgets::window_button::WindowButtonAction;

fn build_ui() -> impl Widget<LauncherData> {
    let title_font = FontDescriptor {
        family: FontFamily::default(),
        size: 18.0,
        weight: FontWeight::BOLD,
        style: FontStyle::default(),
    };

    let version_font = title_font.clone().with_size(14.0);

    let title_label = Label::new("CoopAndreas").with_font(title_font);

    let draggable_bg =
        Container::new(SizedBox::empty().expand()).background(Colors::BackgroundGrey);

    let window_buttons = Flex::row()
        .with_child(
            WindowButton::new::<LauncherData>("window_minimize", Size::new(16.0, 16.0))
                .controller(WindowButtonController::new(WindowButtonAction::Minimize)),
        )
        .with_spacer(20.0)
        .with_child(
            WindowButton::new::<LauncherData>("window_close", Size::new(14.0, 14.0))
                .controller(WindowButtonController::new(WindowButtonAction::Close)),
        )
        .with_spacer(10.0)
        .padding(5.0);

    let top_bar = ZStack::new(draggable_bg)
        .with_child(
            title_label,
            Vec2::new(1.0, 1.0),
            Vec2::ZERO,
            UnitPoint::CENTER,
            Vec2::ZERO,
        )
        .with_child(
            window_buttons,
            Vec2::new(1.0, 1.0),
            Vec2::ZERO,
            UnitPoint::RIGHT,
            Vec2::ZERO,
        )
        .fix_height(60.0)
        .expand_width()
        .controller(DragWindowController);

    let row_links = Align::horizontal(
        UnitPoint::BOTTOM_LEFT,
        Flex::row()
            .with_child(LinkIcon::new::<LauncherData>("github_logo", GITHUB_URL))
            .with_spacer(10.0)
            .with_child(LinkIcon::new::<LauncherData>("discord_logo", DISCORD_URL)),
    );

    let version = Align::horizontal(
        UnitPoint::BOTTOM_RIGHT,
        Flex::<LauncherData>::row().with_child(
            Label::new(|data: &LauncherData, _env: &_| data.version).with_font(version_font),
        ),
    );

    let bottom_row = Flex::row()
        .cross_axis_alignment(CrossAxisAlignment::End)
        .with_flex_child(row_links.expand_width().padding(7.0), 1.0)
        .with_child(version.padding(6.0));

    let content = Flex::column()
        .with_child(top_bar)
        .with_flex_spacer(1.0)
        .with_child(bottom_row)
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
        .launch(LauncherData {
            version: env!("CARGO_PKG_VERSION"),
            is_hot_button: false,
        })
        .expect("Failed to launch application");
}
