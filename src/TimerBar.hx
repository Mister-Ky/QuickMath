
import h2d.Graphics;
import h2d.Object;

class TimerBar extends Object {
    public var totalTime : Float;
    public var timePassed : Float;

    public var width : Int;
    public var height : Int;

    public var onComplete : Void->Void;
    var bar : Graphics;

    var completed : Bool = false;

    public function new( parent : Object, width : Int = 200, height : Int = 20, totalTime : Float = 5.0, ?onComplete : Void->Void ) {
        super(parent);

        this.width = width;
        this.height = height;
        this.totalTime = totalTime;
        this.timePassed = 0;
        this.onComplete = onComplete;

        bar = new Graphics(this);
        drawBar();
    }

    public function update(dt : Float) : Void {
        if (completed) return;

        timePassed += dt;
        if (timePassed >= totalTime) {
            timePassed = totalTime;
            completed = true;
            if (onComplete != null) onComplete();
        }

        drawBar();
    }

    function drawBar() : Void {
        bar.clear();
        var currentWidth = Std.int(width * (timePassed / totalTime));
        bar.beginFill(0x0000FF);
        bar.drawRect(0, 0, currentWidth, height);
        bar.endFill();
    }

    public function reset() : Void {
        timePassed = 0;
        completed = false;
    }
}
