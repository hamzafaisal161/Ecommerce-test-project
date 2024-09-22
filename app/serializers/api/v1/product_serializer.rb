# frozen_string_literal: true

require 'cloudinary'
module Api
  module V1
    class ProductSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers
      attributes :id, :name, :description, :price, :url
      has_many :comments
      def url
        temp = []
        if object.avatar.present?
          object.avatar.each do |image|
            value = Cloudinary::Utils.cloudinary_url(ActiveStorage::Blob.find(image.blob_id).key)
            value.sub!('upload/', 'upload/v1/ecommerce/')
            temp << value
          end
        else
          temp << 'https://res.cloudinary.com/devsinc-hamza/image/upload/v1664980708/ecommerce/no-product-image_m6t4yl.png'
        end
        temp
      end
    end
  end
end
