# frozen_string_literal: true

module Monetizer
  module Convertor
    def convert_to(new_currency)
      if currency == new_currency
        convert_ratio = 1
      else
        raise ConversationRateError unless currencies[currency][new_currency]

        convert_ratio = currencies[currency][new_currency]
      end
      converted_amount = (big_decimal(@amount) * big_decimal(convert_ratio))
      Money.new(converted_amount, new_currency)
    end
  end
end
