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
    invoice_item_lines = CSV.open(file, headers: true, header_converters: :symbol)
    invoice_item_lines.each do |row|
      invoice_item = InvoiceItem.new(row, self)
      all << invoice_item
    end
    invoice_item_lines.close
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
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


end
