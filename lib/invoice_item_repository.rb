require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :all


  def initialize(file, sales_engine)
    @all = []
    @sales_engine = sales_engine
    populate_invoice_item_repo(file)
  end

  def populate_invoice_item_repo(file)
    it_lines = CSV.open(file, headers: true, header_converters: :symbol)
    it_lines.each do |row|
      invoice_item = InvoiceItem.new(row, self)
      all << invoice_item
    end
    it_lines.close
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    all.find do |item|
      item.id == id
    end
  end

  def find_all_by_item_id(id)
    all.find_all do |invoice_item|
     invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    all.find_all do |invoice_item|
     invoice_item.invoice_id == id
    end
  end

  def total(invoice_id)
    invoice_items = all.select do |invoice_item|
        invoice_item.invoice_id == invoice_id
    end
    total = invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    total.reduce(:+)
  end


end
