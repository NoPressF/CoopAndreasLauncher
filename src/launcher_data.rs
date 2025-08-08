use druid::{Data, Lens};

use semver::Version;

#[derive(Clone, Data, Lens)]
pub struct LauncherData {
    pub version: &'static str,
}

impl LauncherData {
    #[allow(dead_code)]
    pub fn version_parsed(&self) -> Option<Version> {
        Version::parse(&self.version).ok()
    }
}
