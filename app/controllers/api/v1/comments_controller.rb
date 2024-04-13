module Api
    module V1
        class CommentsController < ApplicationController
            before_action :set_feature
            skip_before_action :verify_authenticity_token, only: [:create]
    
            def create
                
                @comment = @feature.comments.build(body: comment_params[:body], feature_id: comment_params[:feature_id])
                if @comment.save
                    render json: @comment, status: :created
                else
                    render json: @comment.errors, status: :unprocessable_entity
                end
            end
            
            private
            
            def set_feature
                @feature = Feature.find(params[:feature_id])
            end
            
            def comment_params
                params.require(:comment).permit(:body).merge(feature_id: params[:feature_id])
            end
        end
    end
end
  