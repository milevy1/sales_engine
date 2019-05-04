class ApplicationController < ActionController::API
  def attribute_name
    params.keys.first
  end

  def attribute_value
    params.values.first
  end
end
