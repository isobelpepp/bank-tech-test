class Bank

  TODAY = Date.today.strftime("%d/%m/%Y")

  attr_reader :balance, :interactions

  def initialize
    @balance = 0
    @interactions = []
  end

  def deposit(amount)
    @balance += amount
    @interactions << { date: TODAY, credit: amount, debit: 0, balance: @balance }
  end

  def withdraw(amount)
    if (@balance - amount).negative?
      raise 'Insufficient funds!'
    else
      @balance -= amount
      @interactions << { date: TODAY, credit: 0, debit: amount, balance: @balance }
    end
  end

  def statement
    puts "date:     | credit:  | debit:   | balance  |\n"
    @interactions.each { |hash| print "#{hash[:date]}" "|#{hash[:credit].to_s.ljust(10)}" "|#{hash[:debit].to_s.ljust(10)}" "|#{hash[:balance].to_s.ljust(10)}" "|\n" }
  end

end
