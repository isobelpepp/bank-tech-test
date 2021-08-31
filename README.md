# Bank Tech Test

- Access my bank balance ✅
- Deposit money ✅
  - It updates my balance ✅
- Withdraw money ✅
  - Updates balance ✅
- Records the date of interactions ✅
- Can access a formatted version of my bank statement ✅
- Data can be kept in memory ✅
  - Option to save statement ✅
  - Option to load statement ✅

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
- Run 'rspec' in terminal to execute tests and check test coverage
- IRB example:

```
> require './lib/bank.rb'
> bank = Bank.new
> bank.deposit(10)
> bank.statement 
```

Outputs:
```
date       || credit  || debit  || balance
31/08/2021 || 10      || 0      || 10
```
```
> bank.save_statement('file')
```

outputs:
```
"Your statement has been saved to 'file'"
```

```
## new bank object
> new_bank = Bank.new
> new_bank.load_statement('file')

> bank.statement 
```
Outputs: 

```
date       || credit  || debit  || balance
31/08/2021 || 10      || 0      || 10
```
