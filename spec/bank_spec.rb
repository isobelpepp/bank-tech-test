require 'bank'

describe Bank do
  describe '#initialize' do
    it 'starts with a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end
end
