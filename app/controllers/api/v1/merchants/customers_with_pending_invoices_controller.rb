class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  def index
    render json: CustomerSerializer.new(
      Customer.where(id: Invoice.find_by_sql("SELECT i.* FROM invoices i LEFT OUTER JOIN transactions t ON t.invoice_id = i.id WHERE i.merchant_id = #{params[:id]} AND (t.result = 'failed' OR t.result IS null) EXCEPT SELECT i.* FROM invoices i INNER JOIN transactions t ON t.invoice_id = i.id WHERE i.merchant_id = #{params[:id]} AND t.result = 'success'").pluck(:customer_id))
    )
  end
end
