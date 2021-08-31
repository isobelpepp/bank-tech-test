require 'bank_account'

describe 'Bank Account Feature Test' do

  let(:bank_account) { BankAccount.new }

  it 'can handle all transactions and print a statement in reverse chronological order' do
    today = Statement::TODAY

    bank_account.deposit(100)
    bank_account.deposit(5000.50)
    bank_account.withdraw(500.25)
    bank_account.withdraw(200)

    statement =
"date:     | credit:  | debit:   | balance: |
#{today}|0         |200       |4400.25   |
#{today}|0         |500.25    |4600.25   |
#{today}|5000.5    |0         |5100.5    |
#{today}|100       |0         |100       |\n"

    expect { bank_account.print_statement }.to output(statement).to_stdout
  end

end
