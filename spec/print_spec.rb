# frozen_string_literal: true

require 'print'

describe Print do
  describe '#print' do
    it 'returns formatted version of interaction' do
      expect { subject.print([{ date: '01/09/2021', credit: 100, debit: 0, balance: 100 }]) }.to output(
        "date:     | credit:  | debit:   | balance: |\n01/09/2021|100.00    |0.00      |100.00    |\n"
      ).to_stdout
    end
  end
end
