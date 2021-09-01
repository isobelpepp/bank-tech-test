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

  def save(filename)
    file = File.open(filename, 'w')
    write_to_file(file)
    puts "Your statement has been saved to '#{filename}'."
    file.close
  end

  def load(filename)
    raise 'That file does not exist' unless File.exist?(filename)

    file = File.open(filename, 'r')
    read_from_file(file)
    file.close
  end

  def final_balance
    @transactions[-1][:balance]
  end

  private

  def write_to_file(file)
    @transactions.each do |interaction|
      interaction_data = [interaction[:date], interaction[:credit],
                          interaction[:debit], interaction[:balance]]
      file_line = interaction_data.join(',')
      file.puts(file_line)
    end
  end

  def read_from_file(file)
    file.readlines.each do |line|
      date, credit, debit, balance = line.chomp.split(',')
      @transactions <<
        { date: date, credit: credit.to_f, debit: debit.to_f, balance: balance.to_f }
    end
  end
end
