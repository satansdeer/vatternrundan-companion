import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;

class vatternrundancompanionApp extends Application.AppBase {

    private var _positionView as vatternrundancompanionView;
    private var _raceStats as RaceStats;

    function initialize() {
        AppBase.initialize();
        _positionView = new $.vatternrundancompanionView();
	_raceStats = new $.RaceStats();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        // load race route data
        System.println( "Hello Monkey C!" );
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

    //! Update the current position
    //! @param info Position information
    public function onPosition(info as Info) as Void {
	    _positionView.setPosition(info, _raceStats);
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ _positionView, new vatternrundancompanionDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as vatternrundancompanionApp {
    return Application.getApp() as vatternrundancompanionApp;
}
