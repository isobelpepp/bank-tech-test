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
  end
end
