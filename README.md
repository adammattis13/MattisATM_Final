# MattisATM_Final 💾

Welcome to **MattisATM_Final**, a command-line ATM simulation written in Pascal — just like it's 1997. This was built as a final project for my high school computer programming class with Mr. Julio.

## 🏦 Features

- Secure login using a 6-digit account number and 4-digit PIN
- Support for **multiple user accounts** loaded from a file (`accounts.txt`)
- Account balance management:
  - Check balance
  - Deposit funds
  - Withdraw funds (with insufficient balance handling)
- Graceful error handling and input validation
- Option to exit or return to login at any time using `x`
- Auto-saves account changes after logout

## 💾 File Format: `accounts.txt`

Each line in `accounts.txt` contains:
[account_number] [pin] [balance]
Example:
123456 4321 1000.00
654321 1111 500.00
112233 2222 725.50


## 🧠 It's 2025, what the hell is this?

This was the final project for my 1997, 9th grade, progamming class.
The project was designed to demonstrate:
- Use of records, arrays, and file I/O
- Functions and procedures for modular design
- String validation, loops, and conditionals
- Basic security (for its time)


## 🔧 How to Run

1. Make sure you have [Free Pascal](https://www.freepascal.org) installed.
2. Compile the program:
   ```bash
   fpc MattisATM_Final.pas
   ./MattisATM_Final

Make sure accounts.txt is in the same directory!

🧑‍🏫 Credit: Created by Adam Mattis, submitted as part of the 1997 final project for Mr. Julio’s computer programming class.
Modernized slightly for Git and Free Pascal on macOS. 😎
