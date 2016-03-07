module ApplicationHelper
  def get_distance(lat, lon)
    query = {
      query: {
        filtered: {
          filter: {
            geo_distance: {
              distance: '100km',
              location: {
                lat: lat,
                lon: lon
              }
            }
          }
        }
      },
      sort: [
        {
          _geo_distance: {
            location: { 
              lat:  lat,
              lon: lon
            },
            order: "asc",
            unit: "km", 
            distance_type: "plane" 
          }
        }
      ]
    }
    Hospital.search(query).response.hits.hits[0]["sort"].first
  end

  # get_disance_by_poinit_point(31.018188, 121.196516, 31.012188, 121.196111)    
  def get_disance_by_poinit_point(location)
    location2 = $redis_position.get(request.remote_ip)

    lat1, lon1 = location.split(',').map(&:to_f)
    if location2.present?
      lat2, lon2 = location2.split(',').map(&:to_f)
    else
      return 0
    end

    rad_per_deg = 0.017453293  #  PI/180  
    rkm = 6371            
    dlon = lon2 - lon1  
    dlat = lat2 - lat1  
     
    dlon_rad = dlon * rad_per_deg  
    dlat_rad = dlat * rad_per_deg  
     
    lat1_rad = lat1 * rad_per_deg  
    lon1_rad = lon1 * rad_per_deg  
     
    lat2_rad = lat2 * rad_per_deg  
    lon2_rad = lon2 * rad_per_deg  
     
    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2  
    c = 2 * Math.asin( Math.sqrt(a))  
     
    (rkm * c).round(3)
  end
end