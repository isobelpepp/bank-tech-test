# frozen_string_literal: true

# Prints out bank statement
class Print
  HEADER = "date:     | credit:  | debit:   | balance: |\n"

  def print(transaction_history)
    statement_rows = transaction_history.reverse.map do |h|
      format_row(h)
    end
    puts HEADER + statement_rows.join("\n")
  end

  private

  def format_row(row)
    "#{row[:date]}|#{format_value(row[:credit])}|#{format_value(row[:debit])}|#{format_value(row[:balance])}|"
  end

  def format_value(value)
    format('%.2f', value).to_s.ljust(10)
  end
end
