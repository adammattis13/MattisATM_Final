program MattisATM_Final;

uses crt;

const
  MaxAccounts = 100;           { Maximum number of accounts supported }
  FileName = 'accounts.txt';   { File storing account information }

type
  Account = record
    number: string;            { 6-digit account number }
    pin: string;               { 4-digit PIN }
    balance: real;             { Account balance }
  end;

var
  accounts: array[1..MaxAccounts] of Account; { Array to hold account data }
  accountCount, i, choice: integer;
  input, enteredAccount, enteredPin: string;
  currentIndex: integer;

{--------------------}
{ Function to validate account number format }
function IsValidAccount(acc: string): boolean;
begin
  IsValidAccount := (Length(acc) = 6);
end;

{ Function to validate PIN format }
function IsValidPIN(p: string): boolean;
begin
  IsValidPIN := (Length(p) = 4);
end;

{--------------------}
{ Procedure to load accounts from the file into the array }
procedure LoadAccountsFromFile;
var
  f: text;
  num, p: string;
  bal: real;
begin
  assign(f, FileName);
  {$I-} reset(f); {$I+}
  if IOResult <> 0 then
  begin
    writeln('Error: Unable to open ', FileName);
    halt;
  end;

  accountCount := 0;

  while not eof(f) do
  begin
    readln(f, num, p, bal);
    inc(accountCount);
    accounts[accountCount].number := num;
    accounts[accountCount].pin := p;
    accounts[accountCount].balance := bal;
  end;

  close(f);
end;

{ Procedure to save the current state of accounts back to the file }
procedure SaveAccountsToFile;
var
  f: text;
begin
  assign(f, FileName);
  rewrite(f);
  for i := 1 to accountCount do
    writeln(f, accounts[i].number, ' ', accounts[i].pin, ' ', accounts[i].balance:0:2);
  close(f);
end;

{--------------------}
{ Procedure to display the ATM menu and handle user choices }
procedure ShowMenu;
var
  amount: real;
begin
  repeat
    writeln;
    writeln('---- ATM Menu ----');
    writeln('1. Check Balance');
    writeln('2. Deposit Money');
    writeln('3. Withdraw Money');
    writeln('4. Logout');
    write('Enter your choice: ');
    readln(input);

    if input = 'x' then exit;

    val(input, choice);

    case choice of
      1: writeln('Your current balance is: $', accounts[currentIndex].balance:0:2);

      2: begin
           write('Enter amount to deposit (or x to cancel): ');
           readln(input);
           if input = 'x' then continue;
           val(input, amount);
           if amount > 0 then
           begin
             accounts[currentIndex].balance := accounts[currentIndex].balance + amount;
             writeln('Deposit successful. New balance: $', accounts[currentIndex].balance:0:2);
           end
           else
             writeln('Invalid deposit amount.');
         end;

      3: begin
           write('Enter amount to withdraw (or x to cancel): ');
           readln(input);
           if input = 'x' then continue;
           val(input, amount);
           if (amount > 0) and (amount <= accounts[currentIndex].balance) then
           begin
             accounts[currentIndex].balance := accounts[currentIndex].balance - amount;
             writeln('Withdrawal successful. New balance: $', accounts[currentIndex].balance:0:2);
           end
           else
             writeln('Insufficient funds or invalid amount.');
         end;

      4: begin
           writeln('Logging out...');
           SaveAccountsToFile;
         end;

    else
      writeln('Invalid choice.');
    end;

  until (choice = 4) or (input = 'x');
end;

{--------------------}
{ Function to find the index of an account based on account number and PIN }
function FindAccountIndex(accNum, accPin: string): integer;
begin
  for i := 1 to accountCount do
    if (accounts[i].number = accNum) and (accounts[i].pin = accPin) then
    begin
      FindAccountIndex := i;
      exit;
    end;
  FindAccountIndex := -1;  { Account not found }
end;

{--------------------}
{ Main program execution starts here }
begin
  clrscr;
  LoadAccountsFromFile;

  while true do
  begin
    writeln('====== Welcome to MattisATM_Final ======');

    { Prompt for account number }
    write('Enter your 6-digit account number (or x to exit): ');
    readln(enteredAccount);
    if enteredAccount = 'x' then break;

    if not IsValidAccount(enteredAccount) then
    begin
      writeln('Invalid account number format. Try again.');
      continue;
    end;

    { Prompt for PIN }
    write('Enter your 4-digit PIN (or x to return): ');
    readln(enteredPin);
    if enteredPin = 'x' then continue;

    if not IsValidPIN(enteredPin) then
    begin
      writeln('Invalid PIN format. Try again.');
      continue;
    end;

    { Authenticate user }
    currentIndex := FindAccountIndex(enteredAccount, enteredPin);

    if currentIndex <> -1 then
    begin
      writeln('Login successful.');
      ShowMenu;
    end
    else
      writeln('Incorrect account number or PIN. Try again.');
  end;

  writeln('Goodbye!');
  readln;
end.
