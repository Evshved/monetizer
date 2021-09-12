# frozen_string_literal: true

module Monetizer
  module ConversationRates
    def currencies
      @@currencies ||= {}
    end

    def conversion_rates(currency, rates)
      currencies
      @@currencies[currency] = {} if currencies[currency].nil?
      @@currencies[currency] = @@currencies[currency].merge(rates)
      @@currencies[currency].each do |temp_currency, temp_value|
        @@currencies[temp_currency] = {} if @@currencies[temp_currency].nil?
        @@currencies[temp_currency][currency] = 1 / BigDecimal(temp_value, 8)
      end
    end
  end
end
