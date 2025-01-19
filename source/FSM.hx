class FSM {
    public var activeState: Float -> Void;
    public function new(iState: Float -> Void) {
        this.activeState = iState;
    }

    public function udpate(dt: Float) {
        this.activeState(dt);
    }
}