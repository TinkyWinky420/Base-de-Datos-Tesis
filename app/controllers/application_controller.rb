class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :bloquear_edicion_solo_lectura

  private

  def bloquear_edicion_solo_lectura
    return unless ENV["READ_ONLY"] == "true"

    if %w[new edit].include?(params[:action])
      redirect_to nombres_path, alert: "Modo solo lectura: no se pueden modificar tesis."
    end
  end
end
