class FeatureSerializer < ActiveModel::Serializer
    attributes :external_id, :magnitude, :place, :time, :tsunami, :mag_type, :title, :coordinates, :links, :pagination
  
    def type
      'feature'
    end

    def time
      object.time.strftime('%Y-%m-%d %H:%M:%S')
    end
  
    def coordinates
      { longitude: object.longitude, latitude: object.latitude }
    end
    
    def links
      { external_url: object.url }
    end

    def pagination
            
      {
        current_page: instance_options[:context][:current_page],
        total: instance_options[:context][:total],
        per_page: instance_options[:context][:per_page]
      }
    end

  end