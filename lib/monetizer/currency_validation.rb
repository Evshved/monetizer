# frozen_string_literal: true

module Monetizer
  module CurrencyValidation
    def valid_currency?(currency)
      currencies.key?(currency)
    end
  end
end
