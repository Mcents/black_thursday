class Merchant
  attr_reader  :id,
               :name,
               :created_at

  def initialize(hash, mr)
    @id   = hash[:id].to_i
    @name = hash[:name]
    @created_at = hash[:created_at]
    @mr = mr
  end

  def items
    @mr.items_in_merch_repo(id)
  end

  def invoices
    @mr.invoices_in_merch_repo(id)
  end

  def customers
    @mr.customers_in_merch_repo(id)
  end

  def successful_invoices?
    invoices.find_all { |invoice| invoice.is_paid_in_full? }
  end

  def has_pending_invoice?
    invoices.any? do |invoice|
      !invoice.is_paid_in_full?
    end
  end

  def revenue_for_merchant
    successful_invoices?.reduce(0) do |total, invoice|
      if invoice.total.nil?
        total += 0
      else
        total += invoice.total
      end
      total
    end
  end

  def created_month
    month = created_at.split('-')[1].strip.to_i
    case month
    when 1 then 'January'
    when 2 then 'February'
    when 3 then 'March'
    when 4 then 'April'
    when 5 then 'May'
    when 6 then 'June'
    when 7 then 'July'
    when 8 then 'August'
    when 9 then 'September'
    when 10 then 'October'
    when 11 then 'November'
    when 12 then 'December'
    end
  end

end
