class InvoiceItem

  attr_reader :id,
              :item_id,
              :created_at,
              :updated_at,
              :iv_item_repo,
              :invoice_id,
              :unit_price,
              :quantity

  def initialize(hash, iv_item_repo)
    @iv_item_repo  = iv_item_repo
    @id            = hash[:id].to_i
    @item_id       = hash[:item_id].to_i
    @invoice_id    = hash[:invoice_id].to_i
    @quantity      = hash[:quantity].to_i
    @unit_price    = BigDecimal.new(hash[:unit_price], 4) /100
    @created_at    = Time.parse(hash[:created_at])
    @updated_at    = Time.parse(hash[:updated_at])
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
