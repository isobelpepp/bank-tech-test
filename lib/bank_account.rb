# frozen_string_literal: true

require 'date'
require_relative 'statement'
require_relative 'print'

# Manages bank account transactions
class BankAccount
  attr_reader :balance

  def initialize(statement = Statement.new)
    @balance = 0
    @statement = statement
  end

  def deposit(amount)
    raise 'Invalid input!' if invalid_input(amount)

    @balance += amount
    @statement.credit_transaction(amount, @balance)
  end

  def withdraw(amount)
    raise 'Invalid input!' if invalid_input(amount)
    raise 'Insufficient funds!' if insufficient_funds(amount)

    @balance -= amount
    @statement.debit_transaction(amount, @balance)
  end

  def print_statement(to_print = Print.new)
    to_print.print(@statement.transactions)
  end

  private

  def insufficient_funds(amount)
    (@balance - amount).negative?
  end

  def invalid_input(input)
    !(input.is_a?(Integer) || input.is_a?(Float)) || input.negative?
  end
end
