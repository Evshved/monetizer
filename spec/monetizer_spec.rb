# frozen_string_literal: true

RSpec.describe Monetizer::Money do
  it 'has a version number' do
    expect(Monetizer::VERSION).to be '0.1.0'
  end

  let(:foo) { 'bar' }
  let(:execute_rates) { described_class.conversion_rates('EUR', {
    'USD'     => 1.11,
    'Bitcoin' => 0.0047
  })}

  describe '#conversion_rates' do
    let(:valid_hash_rates) { {"USD"=>1.11, "Bitcoin"=>0.0047} }

    it 'return valid hash with rates' do
      expect(execute_rates).to eq(valid_hash_rates)
    end

    let(:valid_array_keys) { ["EUR", "USD", "Bitcoin"] }

    it 'return all currencies rates with reverse combinations' do
      execute_rates
      expect(described_class.currencies.keys).to eq(valid_array_keys)
    end
  end

  context 'when conversion_rates have been set' do
    before(:each) do
      described_class.conversion_rates('EUR', {
        'USD'     => 1.11,
        'BTC' => 0.0047
      })
    end
    
    let(:money) { described_class.new(20, 'EUR') }
    let(:amount) { "20.00" }
    let(:currency) { 'EUR' }

    describe '#amount' do
      it 'returns the amount of money' do
        expect(money.amount).to eq(amount)
      end
    end

    describe '#currency' do
      it 'returns the currency of money' do
        expect(money.currency).to eq(currency)
      end
    end

    describe '#new' do
      it 'get invalid currency error' do
        expect do
          described_class.new(amount, foo)
        end.to raise_error Monetizer::InvalideCurrencyError
      end

      it 'return Monetizer::Money object' do
        expect(
          described_class.new(amount, currency).class
        ).to eq(Monetizer::Money)
      end
    end

    describe '+' do
      it 'return correct result using the single currency' do
        calculation_res = (money + described_class.new(30, 'EUR')).inspect
        expect(calculation_res).to eq('50.00 EUR')
      end

      it 'return correct result using the two currencies' do
        calculation_res = (money + described_class.new(11.1, 'USD')).inspect
        expect(calculation_res).to eq('30.00 EUR')
      end
    end

    describe '*' do
      it 'return correct result using the single currency' do
        calculation_res = (money * described_class.new(35, 'EUR')).inspect
        expect(calculation_res).to eq('700.00 EUR')
      end

      it 'return correct result using the two currencies' do
        calculation_res = (money * described_class.new(35, 'EUR')).inspect
        expect(calculation_res).to eq('700.00 EUR')
      end
    end

    describe '-' do
      it 'return correct result using the single currency' do
        calculation_res = (money - described_class.new(30, 'EUR')).inspect
        expect(calculation_res).to eq('-10.00 EUR')
      end

      it 'return correct result using the two currencies' do
        calculation_res = (money * described_class.new(35, 'EUR')).inspect
        expect(calculation_res).to eq('700.00 EUR')
      end
    end

    describe '/' do
      it 'return correct result using the single currency' do
        calculation_res = (money / described_class.new(42, 'EUR')).inspect
        expect(calculation_res).to eq('0.48 EUR')
      end

      it 'return correct result using the two currencies' do
        calculation_res = (money / described_class.new(31, 'EUR')).inspect
        expect(calculation_res).to eq('0.65 EUR')
      end
    end

    describe 'multiple counting' do
      it 'return correct result using the single currency' do
        calculation_res = (money / described_class.new(42, 'EUR') + described_class.new(42, 'BTC')).inspect
        expect(calculation_res).to eq('8936.65 EUR')
      end
    end

    describe '==' do
      it 'return correct result after converting' do
        btc_value = described_class.new(42, 'BTC')
        euro_value = described_class.new(8936.17, 'EUR')
        expect(btc_value == euro_value).to be true
      end
    end

    describe '<' do
      it 'return correct result after converting' do
        btc_value = described_class.new(42, 'BTC')
        euro_value = described_class.new(9000, 'EUR')
        expect(btc_value < euro_value).to be true
      end
    end
  end
end
