# frozen_string_literal: true

require 'print'

describe Print do
  describe '#print' do
    it 'returns formatted version of interaction' do
      transaction = [{ date: '01/09/2021', credit: 100, debit: nil, balance: 100 }]
      expect { subject.print(transaction) }.to output(
        "date      || credit   || debit    || balance
01/09/2021||100.00    ||          ||100.00\n"
      ).to_stdout
    end
  end
end
