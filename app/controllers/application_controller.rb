class ApplicationController < ActionController::API
  def attribute_name
    params.keys.first
  end

  def attribute_value
    value = params.values.first

    if attribute_name == "unit_price"
      string_dollars_to_integer_cents(value)
    else
      value
    end
  end

  def string_dollars_to_integer_cents(string_dollars)
    (BigDecimal(string_dollars) * 100).to_i
  end
end
