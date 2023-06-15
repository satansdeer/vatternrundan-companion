using Toybox.Lang;
using Toybox.Math;
using Toybox.Time;

class RaceStats {
    static const R = 6371;  // Radius of the earth in km

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


    function closest_point(target, points) {
        var min_distance = haversine(target, points[0]);
        var min_index = 0;
        for (var i = 1; i < points.size(); i++) {
            var current_distance = haversine(target, points[i]);
            if (current_distance < min_distance) {
                min_distance = current_distance;
                min_index = i;
            }
        }
        return min_index;
    }

    function calculate_race_stats(current_location, race_route) {
        System.println("calculate_race_stats ------");
        var total_distance = 0;
        var distances = new [race_route.size()];
        for (var i = 0; i < race_route.size() - 1; i++) {
            distances[i] = haversine(race_route[i], race_route[i+1]);
            total_distance += distances[i];
        }
	System.println("Total distance " + total_distance);
        var progress_point = closest_point(current_location, race_route);
	System.println("Progress point " + progress_point);
        var progress_index = closest_point(current_location, race_route);
	System.println("Progress index " + progress_index);
        var progress_distance = 0;
        for (var i = 0; i < progress_index; i++) {
            progress_distance += distances[i];
	    System.println("--- Progress distance " + progress_distance);
        }
        var race_completion = Math.round((progress_distance / total_distance) * 100);
        var kms_left = total_distance - progress_distance;
        return [race_completion, progress_distance, kms_left];
    }
}
