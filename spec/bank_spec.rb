require 'bank'

describe Bank do

  describe '#initialize' do
    it 'starts with a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#deposit' do
    it 'puts money into bank account and changes balance' do
      expect { subject.deposit(100) }.to change { subject.balance }.by(100)
    end
    it 'adds the date, credit, debit into the interaction' do
      subject.deposit(50)
      expect(subject.interactions[0][:date]).to eq Bank::TODAY
      expect(subject.interactions[0][:credit]).to eq 50
      expect(subject.interactions[0][:debit]).to eq 0
    end
  end

  describe '#withdraw' do
    it 'deducts given amount from the balance' do
      subject.deposit(100)
      expect { subject.withdraw(20) }.to change { subject.balance }.by(-20)
    end
    it 'raises error if you do not have sufficient funds' do
      expect { subject.withdraw(10) }.to raise_error 'Insufficient funds!'
    end
    it 'adds the date, debit and balance into the interaction' do
      subject.deposit(50)
      subject.withdraw(30)
      expect(subject.interactions[1][:date]).to eq Bank::TODAY
      expect(subject.interactions[1][:credit]).to eq 0
      expect(subject.interactions[1][:debit]).to eq 30
      expect(subject.interactions[1][:balance]).to eq 20
    end
  end

  describe '#statement' do
    it 'returns formatted version of interaction' do
      subject.deposit(10)
      expect { subject.statement }.to output("date:     | credit:  | debit:   | balance  |\n#{Bank::TODAY}|10        |0         |10        |\n").to_stdout
    end
  end

  describe '#save_statement' do
    it "should create 'filename' and put 'text' in it" do
      subject.deposit(10)
      subject.save_statement('filename')
      expect(File.read('filename')).to include '10'
      expect(File.read('filename')).to include '0'
      expect(File.read('filename')).to include Bank::TODAY
    end
    it 'outputs that the file has been saved' do
      subject.deposit(10)
      expect { subject.save_statement('filename') }.to output("Your statement has been saved to 'filename'.\n").to_stdout
    end
  end

  describe '#load_statement' do
    it 'loads the statement into the bank object' do
      subject.load_statement('filename')
      expect(subject.interactions).to eq([{ date: Bank::TODAY, credit: 10, debit: 0, balance: 10 }])
      expect(subject.balance).to eq 10
    end
    it 'raises an error if the file does not exist' do
      expect { subject.load_statement('non_existent') }.to raise_error 'That file does not exist'
    end
  end

end
