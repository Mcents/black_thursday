class Customer

  attr_reader :id,
              :last_name,
              :created_at,
              :updated_at,
              :cr,
              :first_name


  def initialize(hash, cr)
    @cr                            = cr
    @id                            = hash[:id].to_i
    @first_name                    = hash[:first_name]
    @last_name                     = hash[:last_name]
    @created_at                    = Time.parse(hash[:created_at])
    @updated_at                    = Time.parse(hash[:updated_at])
  end

  def merchants
    @cr.merch_in_cust_repo(id)
  end

end
