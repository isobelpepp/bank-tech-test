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

end
