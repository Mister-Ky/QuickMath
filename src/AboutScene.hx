
class AboutScene extends Scene {
    override function init() {
        var lines = hxd.Res.about.entry.getText().split("\n");

        var start = 0;
        var end = lines.length;
        while (start < end && StringTools.trim(lines[start]) == "") start++;
        while (end > start && StringTools.trim(lines[end - 1]) == "") end--;
        lines = lines.slice(start, end);

        var lineHeight = Main.app.addText(null, "TEXT").textHeight + 4;
        var totalHeight = lines.length * lineHeight;
        var startY = (Main.app.baseWindowSize.y - totalHeight) / 2;

        for (i in 0...lines.length) {
            var lineText = Main.app.addText(this, StringTools.trim(lines[i]));
            lineText.x = (Main.app.baseWindowSize.x - lineText.textWidth * lineText.scaleX) / 2;
            lineText.y = startY + i * lineHeight;
        }
    }

    override public function update(dt : Float) {
        if (hxd.Key.isPressed(hxd.Key.ESCAPE)) {
            SceneManager.changeScene(new MenuScene());
        }
    }
}
