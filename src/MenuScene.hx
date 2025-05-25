
class MenuScene extends Scene {
    var curve : Curve;

    var title : h2d.Text;

    #if debug
    var curve_debug : CurveDebugger;
    #end

    override public function init() {
        curve = new Curve();
        curve.addPoint(0, 1);
        curve.addPoint(1.5, 2);
        curve.addPoint(3, 1);

        title = Main.instance.addText(this, "Quick Math");
        title.x = (Main.instance.baseWindowSize.x - title.textWidth * title.scaleX) / 2;
        title.y = (Main.instance.baseWindowSize.y - title.textHeight * title.scaleY) / 5;

        var buttons = new h2d.Flow(this);
        buttons.layout = h2d.Flow.FlowLayout.Vertical;
        buttons.verticalSpacing = 12;
        Main.instance.addButton(buttons, "Start", () -> SceneManager.changeScene(new GameScene()));
        #if hl
        Main.instance.addButton(buttons, "Exit", () -> Sys.exit(0));
        #end
        var maxWidth = 0;
        for (b in buttons.children) {
            var flow = Std.downcast(b, h2d.Flow);
            if (flow != null && flow.outerWidth > maxWidth)
                maxWidth = flow.outerWidth;
        }
        for (b in buttons.children) {
            var flow = Std.downcast(b, h2d.Flow);
            if (flow != null) {
                flow.minWidth = maxWidth;
                flow.backgroundTile = h2d.Tile.fromColor(0x404040, maxWidth, flow.outerHeight);
            }
        }
        buttons.x = (Main.instance.baseWindowSize.x - buttons.outerWidth) / 2;
        buttons.y = (Main.instance.baseWindowSize.y - buttons.outerHeight) / 2;

        var settings = new h2d.Flow(this);
        settings.layout = h2d.Flow.FlowLayout.Vertical;
        settings.verticalSpacing = 12;
        settings.scale(0.8);
        settings.x = 4;
        settings.y = 4;
        var displayedNumberCount = Main.instance.addSlider(settings, "displayed number count", () -> return Settings.displayedNumberCount, (v) -> Settings.displayedNumberCount = Std.int(v), 2, 20, true);
        var numberDigitCount = Main.instance.addSlider(settings, "number digit count", () -> return Settings.numberDigitCount, (v) -> Settings.numberDigitCount = Std.int(v), 1, 4, true);
        var numberDisplayTime = Main.instance.addSlider(settings, "number display time", () -> return Settings.numberDisplayTime, (v) -> Settings.numberDisplayTime = v, 0.25, 3, false);
        var answerTimeLimit = Main.instance.addSlider(settings, "answer time limit", () -> return Settings.answerTimeLimit, (v) -> Settings.answerTimeLimit = v, 3, 10, false);

        #if debug
        curve_debug = new CurveDebugger(this, 0, 0, 300, 200);
        var centr = new h2d.Graphics(this);
        centr.beginFill(0xFF0000);
        centr.drawCircle(Main.instance.baseWindowSize.x / 2, Main.instance.baseWindowSize.y / 2, 3);
        #end
    }

    override public function update(dt : Float) {
        var t = Main.instance.time % 3;
        var scale = curve.getValue(t);
        title.scaleX = scale;
        title.scaleY = scale;

        title.x = (Main.instance.baseWindowSize.x - title.textWidth * title.scaleX) / 2;
        title.y = (Main.instance.baseWindowSize.y - title.textHeight * title.scaleY) / 5;

        #if debug
        curve_debug.drawCurve(curve, t, 1.0);
        #end
    }
}