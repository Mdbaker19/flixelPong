package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState {

	var player: Paddle;
	var ai: Paddle;
	var AI_SPEED: Int = 40;
	var ball: Ball;

	var text: FlxText;
	var playerScore: Int = 0;
	var aiScore: Int = 0;

	override public function create() {
		super.create();
		player = new Paddle(0, FlxG.height / 2);
		add(player);
		ai = new Paddle(FlxG.width - 20, FlxG.height / 2, false);
		ai.brain.activeState = aiIdle;
		ai.facing = LEFT;
		add(ai);
		ball = new Ball(FlxG.width / 2, FlxG.height / 2, ballScore);
		add(ball);

		text = new FlxText();
		text.text = '${playerScore} | ${aiScore}';
		text.color = FlxColor.CYAN;
		text.size = 32;
		text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLUE, 4);
		text.screenCenter();
		add(text);
	}

	override public function update(dt: Float) {
		super.update(dt);
		ai.brain.udpate(dt);
		FlxG.collide(player, ball, playerPaddleHit);
		FlxG.collide(ai, ball, aiPaddleHit);
		text.text = '${playerScore} | ${aiScore}';
	}

	function playerPaddleHit(player: Paddle, ball: Ball) {
		if (FlxG.random.bool(50)) {
			ball.velocity.x = 140;
		} else {
			ball.velocity.x = 190;
		}
		ball.acceleration.x *= -1;
	}

	function aiPaddleHit(ai: Paddle, ball: Ball) {
		if (FlxG.random.bool(50)) {
			ball.velocity.x = -140;
		} else {
			ball.velocity.x = -190;
		}
		ball.acceleration.x *= -1;
	}

	function ballScore(scorer: Int) {
		if (scorer > 0) {
			playerScore += 1;
		} else {
			aiScore += 1;
		}
		ball.centerOut();
	}

	public function aiIdle(dt: Float) {
		if (ball.x > FlxG.width / 2) {
			ai.brain.activeState = aiMove;
		}
		ai.velocity.y = 0;
	}

    public function aiMove(dt: Float) {
		if (ball.x < FlxG.width / 2) {
			ai.brain.activeState = aiIdle;
		} else {
			if (ball.y < ai.y) {
				ai.velocity.y -= AI_SPEED;
			} else {
				ai.velocity.y += AI_SPEED;
			}
		}
    }
}
