# frozen_string_literal: true

class WishlistPolicy < ApplicationPolicy
  def show?
    check_owner
  end

  def add_product?
    check_owner
  end

  def delete_product?
    check_owner
  end

  private

  def check_owner
    raise Pundit::NotAuthorizedError unless @record.user_id == @user.id

    true
  end
end
