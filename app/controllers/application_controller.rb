class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def self.rate_limit(options = {})
    to = options[:to]
    within = options[:within]
    only = options[:only]
    with = options[:with]

    before_action only: only do
      key = "#{request.remote_ip}:#{controller_name}:#{action_name}"
      count = Rails.cache.read(key).to_i
      Rails.cache.write(key, count + 1, expires_in: within)

      if count && count > to
        ActiveSupport::Notifications.instrument("rate_limit.action_controller", request: request) do
          instance_exec(&with) if with
        end
      end
    end
  end

  def rate_limit_exceeded
    render plain: "Rate limit exceeded. Please try again later.", status: :too_many_requests
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end
