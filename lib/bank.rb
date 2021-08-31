class Bank

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    if (@balance - amount).negative?
      raise 'Insufficient funds!'
    else
      @balance -= amount
    end
  end

end
