import json
import gpxpy
import gpxpy.gpx

# Create a new GPX object
gpx = gpxpy.gpx.GPX()

# Create a new GPX track
gpx_track = gpxpy.gpx.GPXTrack()
gpx.tracks.append(gpx_track)

# Read the JSON file
with open('corrected_data.json') as f:
    data = json.load(f)

# Get the route
route = data['route']

# Add segments to the track
gpx_segment = gpxpy.gpx.GPXTrackSegment()
for coord in route:
    gpx_segment.points.append(gpxpy.gpx.GPXTrackPoint(coord[1], coord[0], elevation=coord[2]))
gpx_track.segments.append(gpx_segment)

# Write the GPX file
with open('route.gpx', 'w') as f:
    f.write(gpx.to_xml())
