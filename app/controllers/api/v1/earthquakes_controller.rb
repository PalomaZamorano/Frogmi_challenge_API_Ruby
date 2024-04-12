module Api
    module V1
        class EarthquakesController < ApplicationController

            def index
                earthquakes = Earthquake.all
                total_entries = earthquakes.count 

                # Filtrar por mag_type si se proporciona
                earthquakes = earthquakes.where(mag_type: params[:filters][:mag_type]) if params[:filters]&.key?(:mag_type)

                # Paginar los resultados
                page = params[:page] || 1
                per_page = [params[:per_page].to_i, 1000].min


                if per_page > 1000
                   status 422
                   return { error: "per_page cannot exceed 1000" }.to_json
                end

                earthquakes = earthquakes.paginate(page: page, per_page: per_page)
                
                render json: earthquakes, 
                    each_serializer: EarthquakeSerializer, 
                    context: { current_page: earthquakes.current_page, total: earthquakes.total_entries, per_page: earthquakes.per_page }
            end
       end
    end        
end