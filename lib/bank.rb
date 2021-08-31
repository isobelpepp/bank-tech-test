require 'date'

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

  def save_statement(filename)
    file = File.open(filename, 'w')
    @interactions.each do |interaction|
      interaction_data = [interaction[:date], interaction[:credit], interaction[:debit], interaction[:balance]]
      csv_line = interaction_data.join(',')
      file.puts(csv_line)
    end
    file.close
  end

end
