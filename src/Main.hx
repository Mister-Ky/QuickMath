
//звуки
//качество цифр
//выравнить цифры в числе
//оптимизация

class Main extends BaseApp {
    public static var app : Main;
    
    override function init() {
        super.init();
        SceneManager.changeScene(new MenuScene());
    }

    override function update(dt : Float) {
        time += dt;

        SceneManager.update(dt);

        if (hxd.Key.isPressed(hxd.Key.F11)) {
            engine.fullScreen = !engine.fullScreen;
        }

        s2d.scaleX = window.width / baseWindowSize.x;
        s2d.scaleY = window.height / baseWindowSize.y;
    }

    static function main() {
        hxd.Res.initEmbed();
        app = new Main();
    }
}
