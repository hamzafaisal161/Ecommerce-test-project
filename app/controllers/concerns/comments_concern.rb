# frozen_string_literal: true

module CommentsConcern
  extend ActiveSupport::Concern

  def attach_avatar(file, comment)
    return if file.blank?

    file.each do |image|
      comment.avatar.attach(image)
    end
  end
end
