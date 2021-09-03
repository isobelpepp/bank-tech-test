# Bank Tech Test

### My Approach

- This project was built using TDD. I went through each of the requirements listed below and cycled through the red, green, refactor phase until each one of them were implemented.

- Access my bank balance ✅
- Deposit money ✅
  - It updates my balance ✅
- Withdraw money ✅
  - Updates balance ✅
- Records the date of interactions ✅
- Can access a formatted version of my bank statement ✅
- Data can be kept in memory ✅

- After these were all implemented I dealt with separation of concerns and split up the bank class into two different classes 
  - This helped to address the different elements of interacting with a bank account and of keeping a history of interactions
- And I tackled some edge cases:
  - Will not let you withdraw more money than is in your bank account
  - Will not take input that isn't a float or an integer
  - Will not take negative numbers


### Example

- Given a client makes a deposit of 1000 on 10-01-2012
- And a deposit of 2000 on 13-01-2012
- And a withdrawal of 500 on 14-01-2012
- When she prints her bank statement she would see:
```
 date      || credit  || debit  || balance
14/01/2012 ||         || 500.00 || 2500.00
13/01/2012 || 2000.00 ||        || 3000.00
10/01/2012 || 1000.00 ||        || 1000.00
```

### Instructions:

- Clone this repository and cd into it
- Run 'bundle install'
- Run 'rspec' in terminal to execute tests and check test coverage
- IRB example:

```
> require './lib/bank_account.rb'
> bank = BankAccount.new
> bank.deposit(10)
> bank.withdraw(5)
> bank.print_statement 
```

Outputs:
```
date       || credit  || debit  || balance
31/08/2021 ||         || 5.00   || 5.00     
31/08/2021 || 10.00   ||        || 10.00    
```
