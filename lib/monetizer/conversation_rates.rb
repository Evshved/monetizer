# frozen_string_literal: true

module Monetizer
  module ConversationRates
    attr_accessor :currencies

    def conversion_rates(currency, rates)
      self.currencies ||= {}
      self.currencies[currency] = {} if self.currencies[currency].nil?
      self.currencies[currency] = self.currencies[currency].merge(rates)
      calculate_reverse_rates(currency)
    end

    private

    def calculate_reverse_rates(currency)
      self.currencies[currency].each do |temp_currency, temp_value|
        if self.currencies[temp_currency].nil?
          self.currencies[temp_currency] = {}
        end
        self.currencies[temp_currency][currency] = 1 / BigDecimal(temp_value, 8)
      end
    end
  end
end
