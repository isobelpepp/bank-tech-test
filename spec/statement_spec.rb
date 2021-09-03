# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'statement'

describe Statement do
  describe '#initialize' do
    it 'starts with no transactions' do
      expect(subject.transactions).to be_empty
    end
  end

  describe '#credit_transcation' do
    it 'adds the date, credit, debit into the transactions' do
      subject.credit_transaction(50, 100)
      expect(subject.transactions[0][:date]).to eq Statement::TODAY
      expect(subject.transactions[0][:credit]).to eq 50
      expect(subject.transactions[0][:debit]).to eq nil
    end
  end

  describe '#debit_transaction' do
    it 'adds the date, debit and balance into the interaction' do
      subject.credit_transaction(50, 100)
      subject.debit_transaction(30, 100)
      expect(subject.transactions[1][:date]).to eq Statement::TODAY
      expect(subject.transactions[1][:credit]).to eq nil
      expect(subject.transactions[1][:debit]).to eq 30
      expect(subject.transactions[1][:balance]).to eq 100
    end
  end

  describe '#final_balance' do
    it 'provides most recent balance from interactions' do
      subject.credit_transaction(50, 100)
      expect(subject.final_balance).to eq 100
    end
  end
end

# rubocop:enable Metrics/BlockLength
