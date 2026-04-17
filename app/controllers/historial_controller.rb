class HistorialController < ApplicationController
  def index
    @historiales = Historial.order(created_at: :desc)
  end
end