
class BaseApp extends hxd.App {
    public var window : hxd.Window;
    public var baseWindowSize : h2d.col.IPoint;
    public var font : h2d.Font;
    public var time = 0.;

    override function init() {
        window = hxd.Window.getInstance();
        baseWindowSize = new h2d.col.IPoint(window.width, window.height);
        font = hxd.Res.font.toSdfFont(32, h2d.Font.SDFChannel.Alpha, 0.48, 0.02);
    }

    public function addButton( parent : h2d.Object, label : String, onClick : Void -> Void ) {
        var f = new h2d.Flow(parent);
        f.padding = 5;
        f.paddingBottom = 10;
        f.backgroundTile = h2d.Tile.fromColor(0x404040);
        var tf = new h2d.Text(font, f);
        tf.text = label;
        f.getProperties(tf).horizontalAlign = h2d.Flow.FlowAlign.Middle;
        f.enableInteractive = true;
        f.interactive.cursor = Button;
        f.interactive.onClick = function(_) onClick();
        f.interactive.onOver = function(_) f.backgroundTile = h2d.Tile.fromColor(0x606060);
        f.interactive.onOut = function(_) f.backgroundTile = h2d.Tile.fromColor(0x404040);
        return f;
    }

    public function addSlider( parent : h2d.Object, label : String, get : Void -> Float, set : Float -> Void, min : Float = 0., max : Float = 1., show_int : Bool = false ) {
        var f = new h2d.Flow(parent);
        f.layout = h2d.Flow.FlowLayout.Vertical;
        f.verticalSpacing = 2;

        var tf1 = new h2d.Text(font, f);
        tf1.text = label;

        var fd = new h2d.Flow(f);
        fd.horizontalSpacing = 10;

        var sli = new h2d.Slider(200, 18, fd);
        sli.minValue = min;
        sli.maxValue = max;
        sli.value = get();

        var tf2 = new h2d.Text(font, fd);
        tf2.text = "" + (show_int ? Std.int(sli.value) : hxd.Math.fmt(sli.value));
        sli.onChange = function() {
            set(sli.value);
            tf2.text = "" + (show_int ? Std.int(sli.value) : hxd.Math.fmt(sli.value));
            f.needReflow = true;
        };
        return sli;
    }

    public function addText( parent : h2d.Object, text = "" ) {
        var tf = new h2d.Text(font, parent);
        tf.text = text;
        return tf;
    }

    public function addOutlinedText( parent : h2d.Object, text = "" ) {
        var tf = new msdf.OutlinedText(font, parent);
        tf.text = text;
        return tf;
    }
}
