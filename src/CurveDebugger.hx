
#if debug

import h2d.Graphics;
import h2d.Scene;

class CurveDebugger {
    var g : Graphics;
    var x : Int;
    var y : Int;
    var w : Int;
    var h : Int;

    public function new( scene : Scene, x : Int = 0, y : Int = 0, w : Int = 200, h : Int = 200 ) {
        this.g = new Graphics(scene);
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }

    public function drawCurve( curve : Curve, ?cursorTime : Float, zeroValue : Float = 1.0 ) : Void {
        clear();

        if (curve.points.length < 2) return;

        var tMin = curve.points[0].t;
        var tMax = curve.points[curve.points.length - 1].t;
        var vMin = Math.POSITIVE_INFINITY;
        var vMax = Math.NEGATIVE_INFINITY;

        for (p in curve.points) {
            if (p.value < vMin) vMin = p.value;
            if (p.value > vMax) vMax = p.value;
        }

        vMin -= 0.1;
        vMax += 0.1;

        g.lineStyle(1, 0x888888);

        var zeroY = y + h - ((zeroValue - vMin) / (vMax - vMin)) * h;
        g.moveTo(x, zeroY);
        g.lineTo(x + w, zeroY);

        g.moveTo(x, y);
        g.lineTo(x, y + h);

        g.lineStyle(2, 0x00AAFF);
        var samples = 100;

        for (i in 0...samples) {
            var t = tMin + (i / (samples - 1)) * (tMax - tMin);
            var v = curve.getValue(t);

            var px = x + (t - tMin) / (tMax - tMin) * w;
            var py = y + h - ((v - vMin) / (vMax - vMin)) * h;

            if (i == 0) g.moveTo(px, py);
            else g.lineTo(px, py);
        }

        if (cursorTime != null) {
            var v = curve.getValue(cursorTime);
            var px = x + (cursorTime - tMin) / (tMax - tMin) * w;
            var py = y + h - ((v - vMin) / (vMax - vMin)) * h;

            g.lineStyle(0, 0);
            g.beginFill(0xFF0000);
            g.drawCircle(px, py, 3);
            g.endFill();
        }
    }

    public function clear() : Void {
        g.clear();
    }
}

#end
