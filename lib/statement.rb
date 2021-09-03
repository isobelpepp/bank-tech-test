# frozen_string_literal: true

# Handles bank statements from bank account object
class Statement
  TODAY = Date.today.strftime('%d/%m/%Y')

  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def credit_transaction(amount, balance)
    @transactions << { date: TODAY, credit: amount, debit: nil, balance: balance }
  end

  def debit_transaction(amount, balance)
    @transactions << { date: TODAY, credit: nil, debit: amount, balance: balance }
  end

  def final_balance
    @transactions[-1][:balance]
  end
end
