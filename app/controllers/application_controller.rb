# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationsConcern
  include Pundit::Authorization

  before_action :configure_permitted_parameters,
                if: :devise_controller?
  before_action :set_query
  before_action :initialize_session_cart
  before_action :load_cart

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  rescue_from NoMethodError, with: :action_missing
  rescue_from PayPal::SDK::Core::Exceptions::UnauthorizedAccess, with: :not_authorized_error

  def action_missing
    redirect_to root_path, notice: I18n.t(:method_missing)
  end

  def routing_error(_error = 'Routing error', _status = :not_found, _exception = nil)
    redirect_to root_path, notice: I18n.t(:invalid_path)
  end

  def record_not_found
    flash[:notice] = I18n.t(:record_missing)
    redirect_to(request.referer || root_path)
  end

  def set_query
    @query = Product.ransack(params[:q])
    redirect_to search_path(params[:q].to_enum.to_h) if params[:q].present?
  end

  def not_authorized_error
    flash[:notice] = I18n.t(:not_authorized)
    redirect_to root_path
  end

  def invalid_record
    flash[:notice] = I18n.t(:change_rejected)
    redirect_to(request.referer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[name contact_no gender address avatar new_user])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name contact_no gender address avatar new_user])
  end
end
