import Toybox.Lang;
import Toybox.WatchUi;

class vatternrundancompanionDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new vatternrundancompanionMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}