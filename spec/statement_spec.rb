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
      expect(subject.transactions[0][:debit]).to eq 0
    end
  end

  describe '#debit_transaction' do
    it 'adds the date, debit and balance into the interaction' do
      subject.credit_transaction(50, 100)
      subject.debit_transaction(30, 100)
      expect(subject.transactions[1][:date]).to eq Statement::TODAY
      expect(subject.transactions[1][:credit]).to eq 0
      expect(subject.transactions[1][:debit]).to eq 30
      expect(subject.transactions[1][:balance]).to eq 100
    end
  end

  describe '#print_statement' do
    it 'returns formatted version of interaction' do
      subject.credit_transaction(50, 100)
      expect { subject.print }.to output("date:     | credit:  | debit:   | balance: |
#{Statement::TODAY}|50        |0         |100       |\n").to_stdout
    end
  end

  describe '#save' do
    it "should create 'filename' and put 'text' in it" do
      subject.credit_transaction(50, 100)
      subject.save('filename')
      expect(File.read('filename')).to include '50'
      expect(File.read('filename')).to include '100'
      expect(File.read('filename')).to include BankAccount::TODAY
    end
    it 'outputs that the file has been saved' do
      subject.credit_transaction(50, 100)
      expect { subject.save('filename') }.to output("Your statement has been saved to 'filename'.\n").to_stdout
    end
  end

  describe '#load' do
    it 'loads the statement into the bank object' do
      subject.load('filename')
      expect(subject.transactions).to eq([{ date: BankAccount::TODAY, credit: 50, debit: 0, balance: 100 }])
    end
    it 'raises an error if the file does not exist' do
      expect { subject.load('non_existent') }.to raise_error 'That file does not exist'
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
