require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class Invoice
  attr_reader :idea,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(hash, iv_repo)
    @iv_repo     = iv_repo
    @id          = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status      = hash[:status]
    @created_at  = Time.parse(hash[:created_at])
    @updated_at  = Time.parse(hash[:updated_at])
  end

end
