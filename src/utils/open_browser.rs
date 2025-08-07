use std::process::Command;

pub fn open_in_browser(url: &str) {
    Command::new("cmd")
        .args(&["/C", "start", url])
        .spawn()
        .expect("Failed to open URL");
}
