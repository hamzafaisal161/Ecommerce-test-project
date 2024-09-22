# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def update?
    check_owner
  end

  def edit?
    check_owner
  end

  def destroy?
    check_owner
  end

  def show?
    true
  end

  private

  def check_owner
    raise Pundit::NotAuthorizedError unless @record.user_id == @user.id

    true
  end
end
