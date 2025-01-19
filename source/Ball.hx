import flixel.FlxG;
import flixel.FlxSprite;

class Ball extends FlxSprite {

    var scoreCb: (Int) -> Void;
    var baseAcc: Int = 320;
    var baseVel: Int = 160;

    public function new(x: Float, y: Float, scoreCallBack: (Int) -> Void) {
        super(x, y);
        loadGraphic('assets/images/ball.png', true, 10, 10);
        animation.add('move', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 4);
        animation.play('move');
        acceleration.x = baseAcc;
        acceleration.y = baseAcc;
		maxVelocity.x = baseVel;
        maxVelocity.y = baseVel;

        this.scoreCb = scoreCallBack;
    }

    public override function update(dt: Float) {
        super.update(dt);
        if (this.x >= FlxG.width - width) {
            this.scoreCb(1);
        }
        if (this.x <= 0) {
            this.scoreCb(-1);
        }
        if (this.y >= FlxG.height - width || this.y <= 0) {
            velocity.y *= -1;
            acceleration.y *= -1;
        }
    }

    public function centerOut() {
        x = FlxG.width / 2;
        y = FlxG.height / 2;
        if (FlxG.random.bool(50)) {
            velocity.x = baseVel;
            acceleration.x = baseAcc;
        } else {
            velocity.x = -baseVel;
            acceleration.x = -baseAcc;
        }
    }
}