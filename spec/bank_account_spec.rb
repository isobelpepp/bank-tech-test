require 'bank_account'

describe BankAccount do

  let(:statement) { double(:statement) }
  let(:bank_account) { BankAccount.new(statement) }

  before do 
    allow(statement).to receive(:debit_transaction)
    allow(statement).to receive(:credit_transaction)
    allow(statement).to receive(:final_balance).and_return(100)
    allow(statement).to receive(:load).and_return('statement loaded!')
    allow(statement).to receive(:save).and_return('statement saved!')
  end

  describe '#initialize' do
    it 'starts with a balance of 0' do
      expect(bank_account.balance).to eq 0
    end
  end

  describe '#deposit' do
    it 'puts money into bank account and changes balance' do
      expect { bank_account.deposit(100) }.to change { bank_account.balance }.by(100)
    end
    it 'raises error if you do not put in integer or float' do
      expect { bank_account.withdraw(:something) }.to raise_error 'Invalid input!'
    end
    it 'raises error if you put in a negative number' do
      expect { bank_account.withdraw(-10) }.to raise_error 'Invalid input!'
    end
  end

  describe '#withdraw' do
    it 'deducts given amount from the balance' do
      bank_account.deposit(100)
      expect { bank_account.withdraw(20) }.to change { bank_account.balance }.by(-20)
    end
    it 'raises error if you do not have sufficient funds' do
      expect { bank_account.withdraw(10) }.to raise_error 'Insufficient funds!'
    end
    it 'raises error if you do not put in integer or float' do
      expect { bank_account.withdraw('something') }.to raise_error 'Invalid input!'
    end
  end

  describe '#print_statement' do
    it 'responds to print method' do
      allow(statement).to receive(:print).and_return('Statement printed!')
      expect(bank_account.print_statement).to eq('Statement printed!')
    end
  end

  describe '#save_statement' do
    it 'responds to save_statement method' do
      bank_account.save_statement('file')
      expect(bank_account.save_statement('file')).to eq 'statement saved!'
    end
    it 'calls save method on statement' do
      bank_account.save_statement('file')
      expect(statement).to have_received(:save)
    end
  end

  describe '#load_statement' do
    it 'calls load method on statement' do
      bank_account.load_statement('file')
      expect(statement).to have_received(:load)
    end
    it 'updates the balance upon loading' do
      bank_account.load_statement('file')
      expect(bank_account.balance).to eq 100
    end 
  end

end
