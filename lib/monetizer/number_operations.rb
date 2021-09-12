# frozen_string_literal: true

module Monetizer
  module NumberOperations
    %i[+ - * /].each do |meth|
      define_method(meth) do |money|
        second_elem = if money.class == Monetizer::Money
                        money
                      else
                        Money.new(money, currency)
                      end
        money_object = second_elem.convert_to(currency)
        new_amount = big_decimal(amount).send(meth, big_decimal(money_object.amount))
        Money.new(new_amount, currency)
      end
    end

    %i[== < > <= >=].each do |meth|
      define_method(meth) do |money|
        amount.send(meth, money.convert_to(currency).amount)
      end
    end

    def big_decimal(value)
      BigDecimal(value, 8)
    end
  end
end
