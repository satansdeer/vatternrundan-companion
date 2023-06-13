import json
from math import radians, cos, sin, sqrt, atan2

def haversine(coord1, coord2):
    R = 6371  # Radius of the earth in km
    lon1, lat1, _ = coord1
    lon2, lat2, _ = coord2
    dlat = radians(lat2 - lat1)
    dlon = radians(lon2 - lon1)
    a = sin(dlat / 2) ** 2 + cos(radians(lat1)) * cos(radians(lat2)) * sin(dlon / 2) ** 2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    return R * c  # Distance in km

def closest_point(target, points):
    return min(points, key=lambda point: haversine(target, point))

def correct_checkpoints(file_name):
    with open(file_name, 'r', encoding='utf-8') as f:
        data = json.load(f)

    route = data['route']
    checkpoints = data['checkpoints']

    # corrected_checkpoints = {}
#
    # for checkpoint, coords in checkpoints.items():
        # closest_coords = closest_point(coords, route)
        # corrected_checkpoints[checkpoint] = closest_coords
#
    # data['checkpoints'] = corrected_checkpoints
#
    # with open('corrected_data.json', 'w', encoding='utf-8') as f:
        # json.dump(data, f, indent=4, ensure_ascii=False)

# correct_checkpoints('./race.json')

def calculate_race_stats(current_location, race_route):
    total_distance = sum(haversine(coord1, coord2) for coord1, coord2 in zip(race_route, race_route[1:]))
    progress_point = closest_point(current_location, race_route)
    print(race_route.index(progress_point))
    progress_distance = sum(haversine(coord1, coord2) for coord1, coord2 in zip(race_route[:race_route.index(progress_point)], race_route[1:race_route.index(progress_point)+1]))
    race_completion = round((progress_distance / total_distance) * 100, 2)
    kms_left = total_distance - progress_distance
    return race_completion, progress_distance, kms_left

def test_race_stats(file_name):
    with open(file_name, 'r', encoding='utf-8') as f:
        data = json.load(f)

    route = data['route']
    checkpoints = data['checkpoints']
    for checkpoint_name, checkpoint_location in checkpoints.items():
        print(f"Checkpoint location: {checkpoint_location}")
        race_completion, kms_passed, kms_left = calculate_race_stats(checkpoint_location, route)
        print(f"For checkpoint {checkpoint_name}:")
        print(f"Race completion: {race_completion}%")
        print(f"Kilometers passed: {kms_passed} km")
        print(f"Kilometers left: {kms_left} km\n")

test_race_stats("./corrected_data.json")
