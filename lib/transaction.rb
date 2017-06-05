class Transaction

  attr_reader :id,
              :credit_card_number,
              :created_at,
              :updated_at,
              :tr,
              :credit_card_expiration_date,
              :result,
              :invoice_id

  def initialize(hash, tr)
    @tr                            = tr
    @id                            = hash[:id].to_i
    @invoice_id                    = hash[:invoice_id].to_i
    @credit_card_number            = hash[:credit_card_number].to_i
    @credit_card_expiration_date   = hash[:credit_card_expiration_date]
    @result                        = hash[:result].to_sym
    @created_at                    = Time.parse(hash[:created_at])
    @updated_at                    = Time.parse(hash[:updated_at])
  end


end
