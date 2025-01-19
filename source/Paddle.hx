package;

import flixel.FlxG;
import flixel.FlxSprite;

class Paddle extends FlxSprite {

    var isPlayer: Bool;
    public var brain: FSM;

    public function new(x: Float, y: Float, isPlayer: Bool = true) {
        super(x, y);
        immovable = true;
		loadGraphic('assets/images/paddle.png', false, 20, 100);
        setFacingFlip(LEFT, true, false);
        this.isPlayer = isPlayer;
        if (isPlayer) {
            this.brain = null;
        } else {
            maxVelocity.y = 120;
            this.brain = new FSM((Float) -> {});
        }
    }


    public override function update(dt: Float) {
        super.update(dt);
        if (this.isPlayer) {
            var up: Bool = false;
            var down: Bool = false;
            var iosTouch: Int = 0;
            #if ios
            if (FlxG.touches != null) {
                if (FlxG.touches.justStarted().length > 0) {
                    var touchY: Float = FlxG.touches.getFirst().justPressedPosition.y;
                    iosTouch = 850;
                    if (touchY >= FlxG.height / 2) {
                        down = true;
                    } else {
                        up = true;
                    }
                }
            }
            #end
            
            #if html5
            up = FlxG.keys.anyPressed([UP]);
            down = FlxG.keys.anyPressed([DOWN]);
            #end

            if (up && down) {
                up = down = false;
            }
                
            if (up) {
                velocity.y = -150 - iosTouch;
            } else if (down) {
                velocity.y = 150 + iosTouch;
            } else {
                velocity.y = 0;
            }
        }
        clampPos();
    }

    function clampPos() {
        if (this.y <= 0) {
            this.y = 0;
        }
        if (this.y >= FlxG.height - 100) {
            this.y = FlxG.height - 100;
        }
    }

}