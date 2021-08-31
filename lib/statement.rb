class Statement

  TODAY = Date.today.strftime('%d/%m/%Y')

  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def credit_transaction(amount, balance)
    @transactions << { date: TODAY, credit: amount, debit: 0, balance: balance }
  end

  def debit_transaction(amount, balance)
    @transactions << { date: TODAY, credit: 0, debit: amount, balance: balance }
  end

  def print
    puts "date:     | credit:  | debit:   | balance  |\n"
    @transactions.each { |h| puts "#{h[:date]}" "|#{h[:credit].to_s.ljust(10)}" "|#{h[:debit].to_s.ljust(10)}" "|#{h[:balance].to_s.ljust(10)}" "|" }
  end

  def save(filename)
    file = File.open(filename, 'w')
    @transactions.each do |interaction|
      interaction_data = [interaction[:date], interaction[:credit], interaction[:debit], interaction[:balance]]
      csv_line = interaction_data.join(',')
      file.puts(csv_line)
    end
    puts "Your statement has been saved to '#{filename}'."
    file.close
  end

  def load(filename)
    raise 'That file does not exist' unless File.exist?(filename)

    file = File.open(filename, 'r')
    file.readlines.each do |line|
      date, credit, debit, balance = line.chomp.split(',')
      @transactions << { date: date, credit: credit.to_i, debit: debit.to_i, balance: balance.to_i }
    end
    file.close
  end

  def final_balance
    @transactions[-1][:balance]
  end
end
