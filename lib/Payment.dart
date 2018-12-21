import 'dart:core';

class Payment {
  int nr = 0;
  double balance = 0.0;
  double principal = 0.0;
  double interest = 0.0;
  double amount = 0.0;
  double commission = 0.0;

  Payment(
      [int nr,
      double balance,
      double principal,
      double interest,
      double amount]) {
    this.nr = nr;
    this.balance = balance;
    this.principal = principal;
    this.interest = interest;
    this.amount = amount;
  }

  int getNr() {
    return nr;
  }

  void setNr(int nr) {
    this.nr = nr;
  }

  double getBalance() {
    return balance;
  }

  void setBalance(double balance) {
    this.balance = balance;
  }

  double getPrincipal() {
    return principal;
  }

  void setPrincipal(double principal) {
    this.principal = principal;
  }

  double getInterest() {
    return interest;
  }

  void setInterest(double interest) {
    this.interest = interest;
  }

  double getAmount() {
    return amount;
  }

  void setAmount(double amount) {
    this.amount = amount;
  }

  double getCommission() {
    return commission;
  }

  void setCommission(double commission) {
    this.commission = commission;
  }
}
