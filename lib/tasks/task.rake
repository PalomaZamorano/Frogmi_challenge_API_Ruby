namespace :task do
  desc 'Get earthquake data'

  task get_earthquake_data_task: :environment do
    require 'open-uri'
    require 'json'
    
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
    data = JSON.parse(URI.open(url).read)

    data['features'].each do |feature|
      id = feature['id']
      mag = feature['properties']['mag']
      place = feature['properties']['place']
      time = Time.at(feature['properties']['time'] / 1000)
      url = feature['properties']['url']
      tsunami = feature['properties']['tsunami']
      mag_type = feature['properties']['magType']
      title = feature['properties']['title']
      longitude, latitude = feature['geometry']['coordinates']
  
      next if [title, url, place, mag_type, longitude, latitude].any?(&:nil?)
      next if mag < -1.0 || mag > 10.0
      next if latitude < -90.0 || latitude > 90.0
      next if longitude < -180.0 || longitude > 180.0
      
      earthquake = Earthquake.find_by(external_id: id)

      if !earthquake
        Earthquake.create(
          external_id: id,
          magnitude: mag,
          place: place,
          time: time,
          url: url,
          tsunami: tsunami,
          mag_type: mag_type,
          title: title,
          longitude: longitude,
          latitude: latitude
        )
      end

    end
  end

end
