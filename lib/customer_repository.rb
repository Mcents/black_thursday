require 'csv'
require_relative 'customer'

class CustomerRepository
  attr_reader :all,
              :sales_engine

  def initialize(file, sales_engine)
    @all = []
    @sales_engine = sales_engine
    populate_customer_repo(file)
  end

  def populate_customer_repo(file)
    cust_lines = CSV.open(file, headers: true, header_converters: :symbol)
    cust_lines.each do |row|
      cust = Customer.new(row, self)
      all << cust
    end
    cust_lines.close
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    all.find do |cust|
      cust.id == id
    end
  end

  def find_all_by_first_name(name)
    all.find_all do |cust|
     cust.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |cust|
     cust.last_name.downcase.include?(name.downcase)
    end
  end

  def customers_by_id(customer_ids)
    results = customer_ids.map do |customer_id|
      find_by_id(customer_id)
    end
    results.uniq
  end

  def merch_in_cust_repo(customer_id)
    @sales_engine.find_merchants_by_customer_id(customer_id)
  end


end
