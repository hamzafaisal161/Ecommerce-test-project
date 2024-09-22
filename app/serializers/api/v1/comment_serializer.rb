# frozen_string_literal: true

require 'cloudinary'
module Api
  module V1
    class CommentSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers
      include ActionView::Helpers::DateHelper
      attributes :id, :description, :url, :user_name, :stamp
      def url
        temp = []
        object.avatar.each do |image|
          value = Cloudinary::Utils.cloudinary_url(ActiveStorage::Blob.find(image.blob_id).key)
          value.sub!('upload/', 'upload/v1/ecommerce/')
          temp << value
        end
        temp
      end

      def user_name
        "Made by #{object.user.name}"
      end

      def stamp
        if (object.updated_at - object.created_at) > 1
          "Updated #{time_ago_in_words(object.updated_at)} ago"
        else
          "Posted #{time_ago_in_words(object.created_at)} ago"
        end
      end
    end
  end
end
