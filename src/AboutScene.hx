
class AboutScene extends Scene {
    override function init() {
        var label : h2d.Text = Main.app.addText(this, "Developed by");
        label.x = (Main.app.baseWindowSize.x - label.textWidth * label.scaleX) / 2;
        label.y = (Main.app.baseWindowSize.y - label.textHeight * label.scaleY) / 2;
    }

    override public function update(dt : Float) {
        if (hxd.Key.isPressed(hxd.Key.ESCAPE)) {
            SceneManager.changeScene(new MenuScene());
        }
    }
}
