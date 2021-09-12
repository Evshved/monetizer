# frozen_string_literal: true

module Monetizer
  class ConversationRateError < StandardError
    def initialize(msg)
      super(msg)
    end
  end
end
