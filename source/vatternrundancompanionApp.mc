import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class vatternrundancompanionApp extends Application.AppBase {

    hidden var raceRouteData;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        // load race route data
        raceRouteData = WatchUi.loadResource(Rez.JsonData.raceRoute);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new vatternrundancompanionView(), new vatternrundancompanionDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as vatternrundancompanionApp {
    return Application.getApp() as vatternrundancompanionApp;
}
