# frozen_string_literal: true

module Monetizer
  class InvalideCurrencyError < StandardError
    def initialize(msg)
      super(msg)
    end
  end

  class ConversationRateError < StandardError
    def initialize(msg)
      super(msg)
    end
  end
end
