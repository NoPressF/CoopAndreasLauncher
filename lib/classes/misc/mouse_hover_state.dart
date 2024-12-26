class MouseHoverState {
  static bool _isMouseHovered = false;

  static get isMouseHovered => _isMouseHovered;

  static void enableMouseHovered() {
    _isMouseHovered = true;
  }

  static void disableMouseHovered() {
    _isMouseHovered = false;
  }
}