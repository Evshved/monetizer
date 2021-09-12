# frozen_string_literal: true

require_relative 'monetizer/version'
require_relative 'monetizer/errors'
require_relative 'monetizer/number_operations'
require_relative 'monetizer/conversation_rates'
require_relative 'monetizer/currency_validation'
require_relative 'monetizer/convertor'

require 'bigdecimal'

module Monetizer
  class Money
    include Monetizer::NumberOperations
    include Monetizer::Convertor
    extend Monetizer::ConversationRates
    extend Monetizer::CurrencyValidation
    attr_reader :currency

    def initialize(amount, currency)
      raise ConversationRateError, 'Undefined currency' unless self.class.valid_currency?(currency)

      @amount = big_decimal(amount).truncate(2)
      @currency = currency
    end

    def amount
      format('%.2f', @amount)
    end

    def inspect
      "#{amount} #{currency}"
    end

    private

    def currencies
      self.class.currencies
    end
  end
end
