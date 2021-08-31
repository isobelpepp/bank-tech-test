# frozen_string_literal: true

# Handles bank statements from bank account object
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
    puts 'date:     | credit:  | debit:   | balance: |'
    @transactions.reverse_each do |h|
      puts "#{h[:date]}" "|#{format(h[:credit])}" "|#{format(h[:debit])}" "|#{format(h[:balance])}" '|'
    end
  end

  def save(filename)
    file = File.open(filename, 'w')
    @transactions.each do |interaction|
      interaction_data = [interaction[:date], interaction[:credit], interaction[:debit], interaction[:balance]]
      file_line = interaction_data.join(',')
      file.puts(file_line)
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

  private

  def format(value)
    value.to_s.ljust(10)
  end
end
