using Toybox.Math;

class RaceStats {
    static const R = 6371;  // Radius of the earth in km

    hidden var current_checkpoint;
    hidden var next_checkpoint;
    hidden var total_distance;
    hidden var distances;
    hidden var race_route;

    function initialize() {
        var race_data = WatchUi.loadResource(Rez.JsonData.raceRoute);
	race_route = race_data["route"];
        current_checkpoint = 0;
        next_checkpoint = 1;
        total_distance = 0;
        distances = new [race_route.size() - 1];
        for (var i = 0; i < race_route.size() - 1; i++) {
            distances[i] = haversine(race_route[i], race_route[i + 1]);
            total_distance += distances[i];
        }
    }

    function haversine(coord1, coord2) {
        var lon1 = coord1[0];
        var lat1 = coord1[1];
        var lon2 = coord2[0];
        var lat2 = coord2[1];
        var dlat = Math.toRadians(lat2 - lat1);
        var dlon = Math.toRadians(lon2 - lon1);
        var a = Math.pow(Math.sin(dlat / 2), 2) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.pow(Math.sin(dlon / 2), 2);
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;  // Distance in km
    }

    function update_checkpoints(current_location, race_route) {
	System.println("current_location: " + current_location);
	System.println("next_checkpoint: " + race_route[next_checkpoint]);
	System.println("current_checkpoint: " + race_route[current_checkpoint]);
        if (haversine(current_location, race_route[next_checkpoint]) < haversine(current_location, race_route[current_checkpoint])) {
            current_checkpoint = next_checkpoint;
            next_checkpoint += 1;
        }
    }

    function calculate_race_stats(current_location) {
	System.println("current_location: " + current_location);
        update_checkpoints(current_location, race_route);
        var progress_distance = 0;
        for (var i = 0; i < current_checkpoint; i++) {
            progress_distance += distances[i];
        }
        var race_completion = Math.round((progress_distance / total_distance) * 100);
        var kms_left = total_distance - progress_distance;
        return [race_completion, progress_distance, kms_left];
    }
}
