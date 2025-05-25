
class GameScene extends Scene {
    var result = 0;
    var numbers : Array<Int> = [];
    var shownNumbers : Int = 0;
    var time = 0.;
    var stop = false;
    var preGameCountdown = 3;
    var readyText : h2d.Text;
    var countdownText : h2d.Text;

    var number : h2d.Text;
    var timerBar : TimerBar;

    override public function init() {
        #if debug
        trace("----------------------------------------"); //40
        #end

        readyText = Main.instance.addText(this, "Ready");
        readyText.scale(2);
        readyText.textColor = 0x114E0D;
        readyText.x = (Main.instance.baseWindowSize.x - readyText.textWidth * readyText.scaleX) / 2;
        readyText.y = (Main.instance.baseWindowSize.y - readyText.textHeight * readyText.scaleY) / 8;
        countdownText = Main.instance.addText(this);
        countdownText.scale(10);
        countdownText.textColor = 0x0131FF;
        countdownText.text = Std.string(preGameCountdown);
        countdownText.x = (Main.instance.baseWindowSize.x - countdownText.textWidth * countdownText.scaleX) / 2;
        countdownText.y = (Main.instance.baseWindowSize.y - countdownText.textHeight * countdownText.scaleY) / 2;

        number = Main.instance.addText(this);
        number.scale(10);
        number.textColor = 0x3CD302;
    }

    override public function update(dt : Float) {
        if (hxd.Key.isPressed(hxd.Key.ESCAPE)) {
            SceneManager.changeScene(new MenuScene());
        }

        if (countdownText != null) {
            time += dt;
            if (time >= 1.) {
                time = 0.;
                preGameCountdown--;
                if (preGameCountdown == 0) {
                    readyText.remove();
                    readyText = null;
                    countdownText.remove();
                    countdownText = null;
                    new_number();
                } else {
                    countdownText.text = Std.string(preGameCountdown);
                    countdownText.x = (Main.instance.baseWindowSize.x - countdownText.textWidth * countdownText.scaleX) / 2;
                    countdownText.y = (Main.instance.baseWindowSize.y - countdownText.textHeight * countdownText.scaleY) / 2;
                }
            }
            return;
        }

        time += dt;
        if (time >= Settings.numberDisplayTime && !stop) {
            time = 0.;
            if (shownNumbers == Settings.displayedNumberCount) {
                stop = true;
                number.text = "";
                timerBar = new TimerBar(this, 800, 50, Settings.answerTimeLimit, end);
                timerBar.x = (Main.instance.baseWindowSize.x - timerBar.width) / 2;
                timerBar.y = (Main.instance.baseWindowSize.y - timerBar.height) / 2;
            } else {
                new_number();
            }
        }

        if (timerBar != null) {
            timerBar.update(dt);
        }
    }

    function new_number() {
        var min = Std.int(Math.pow(10, Settings.numberDigitCount - 1));
        var max = Std.int(Math.pow(10, Settings.numberDigitCount)) - 1;
        
        var rnumber = min + Std.random(max - min + 1);
        numbers.push(rnumber);
        number.text = Std.string(rnumber);
        shownNumbers++;

        number.x = (Main.instance.baseWindowSize.x - number.textWidth * number.scaleX) / 2;
        number.y = (Main.instance.baseWindowSize.y - number.textHeight * number.scaleY) / 2;

        #if debug
        trace(rnumber);
        #end
    }

    function end() {
        timerBar.remove();
        timerBar = null;

        var rt = Main.instance.addText(this, "Result:");
        rt.scale(2);
        rt.x = (Main.instance.baseWindowSize.x - rt.textWidth * rt.scaleX) / 2;
        rt.y = (Main.instance.baseWindowSize.y - rt.textHeight * rt.scaleY) / 8;

        for (i in numbers) {
            result += i;
        }
        number.text = Std.string(result);

        number.x = (Main.instance.baseWindowSize.x - number.textWidth * number.scaleX) / 2;
        number.y = (Main.instance.baseWindowSize.y - number.textHeight * number.scaleY) / 2;
        
        #if debug
        trace("Result: " + result);
        #end
    }
}
