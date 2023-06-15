import Toybox.Graphics;
import Toybox.WatchUi;

class vatternrundancompanionView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    //! Set the position
    //! @param info Position information
    public function setPosition(info, raceStats) as Void {
	// log position
        var position = info.position;
	var lat = position.toDegrees()[0];
	var lon = position.toDegrees()[1];

	var raceStatsData = raceStats.calculate_race_stats([lon, lat]);

	System.println("RaceRouteData: " + raceStatsData);

        WatchUi.requestUpdate();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
