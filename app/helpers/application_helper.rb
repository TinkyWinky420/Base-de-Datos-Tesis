module ApplicationHelper
  def modo_solo_lectura?
    ENV["READ_ONLY"] == "true"
  end
end
