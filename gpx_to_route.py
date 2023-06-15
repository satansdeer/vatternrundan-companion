import gpxpy
import gpxpy.gpx
import sys

# Get the file name from the arguments
if len(sys.argv) != 2:
    print('Usage: python gpx_to_route.py <file>')
    sys.exit(1)

file_name = sys.argv[1]

# Load the GPX file
with open(file_name) as f:
    gpx = gpxpy.parse(f)

# Extract the coordinates
coords = []
for track in gpx.tracks:
    for segment in track.segments:
        for point in segment.points:
            coords.append([point.longitude, point.latitude, point.elevation || 0])

# Now coords is an array of GPS positions
# print(coords)

# Write the JSON file
with open('route.json', 'w') as f:
    f.write(json.dumps({'route': coords, 'checkpoints': {}}))
