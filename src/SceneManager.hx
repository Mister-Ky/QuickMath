
class SceneManager {
    public static var current : Scene;

    public static function changeScene(newScene : Scene) : Void {
        current = newScene;
        Main.instance.setScene(current);
    }

    public static function update(dt : Float) : Void {
        if (current != null) {
            current.update(dt);
        }
    }
}
