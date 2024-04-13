module Api
    module V1
        class FeaturesController < ApplicationController

            def index
                features = Feature.all
                total_entries = features.count 

                # Filtrar por mag_type si se proporciona
                features = features.where(mag_type: params[:filters][:mag_types]) if params[:filters]&.key?(:mag_types)

                # Paginar los resultados
                page = params[:page] || 1
                per_page = [params[:per_page].to_i, 1000].min


                if per_page > 1000
                   status 422
                   return { error: "per_page cannot exceed 1000" }.to_json
                end

                features = features.paginate(page: page, per_page: per_page)
                
                render json: features, 
                    each_serializer: FeatureSerializer, 
                    context: { current_page: features.current_page, total: features.total_entries, per_page: features.per_page }
            end
       end
    end        
end