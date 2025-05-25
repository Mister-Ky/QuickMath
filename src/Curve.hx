
class Curve {
    public var points : Array<{ t : Float, value : Float }> = [];
    
    public function new() {}
    
    public function addPoint( t : Float, value : Float ) : Void {
        points.push({ t: t, value: value });
        points.sort((a, b) -> Reflect.compare(a.t, b.t));
    }
    
    public function getValue(time : Float) : Float {
        if (points.length == 0)
            return 0;
        
        if (time <= points[0].t)
            return points[0].value;
        
        if (time >= points[points.length - 1].t)
            return points[points.length - 1].value;
        
        for (i in 0...points.length - 1) {
            var p1 = points[i];
            var p2 = points[i + 1];
            
            if (time >= p1.t && time <= p2.t) {
                var f = (time - p1.t) / (p2.t - p1.t); // 0..1
                return lerp(p1.value, p2.value, f);
            }
        }
        
        return 0;
    }
    
    inline function lerp( a : Float, b : Float, f : Float ) : Float {
        return a + (b - a) * f;
    }
}
