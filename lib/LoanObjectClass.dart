class LoanObjectClass {
  double loanAmount;
  int loanInterestType = 0; // 0 - Nominal , 2 - Effective
  double loanInterestPercentage;
  double loanFixedPayment;
  int loanPeriodYears; // int - years of the
  int loanPeriodMonths; // int - months of the
  double loanDownPayment;
  double loanDisposableCommission;
  double loanMonthlyCommission;
  double loanLastPayment;
  double loanSelectedCalc =
      0; // null - Annuity, 1 -  Differentiated, 2 - Fixed Payments

  LoanObjectClass();

  setAmount(double amount) {
    this.loanAmount = amount;
  }

  setInterestType(int type) {
    this.loanInterestType = type;
  }

  setInterestPercentage(double interestPercentage) {
    this.loanInterestPercentage = interestPercentage;
  }

  setFixedPayment(double fixedPayment) {
    this.loanFixedPayment = fixedPayment;
  }

  setPeriodYears(int periodYears) {
    this.loanPeriodYears = periodYears; // stored in years here
  }

  setPeriodMonths(int periodMonths) {
    this.loanPeriodMonths = periodMonths; //stored in month as is
  }

  setDownPayment(double downPayment) {
    this.loanDownPayment = downPayment;
  }

  setDisposableCommission(double disposableCommission) {
    this.loanDisposableCommission = disposableCommission;
  }

  setMonthlyCommission(double monthlyCommission) {
    this.loanMonthlyCommission = monthlyCommission;
  }

  setLastPayment(double lastPayment) {
    this.loanLastPayment = lastPayment;
  }

  calculateAnnuityPayment() {}

  calculateDifferentiated() {}

  calculateFixedPayments() {}

  clearObject() {
    this.loanAmount = null;
    this.loanInterestType = null; // 0 - Nominal , 2 - Effective
    this.loanInterestPercentage = null;
    this.loanFixedPayment = null;
    this.loanPeriodYears = null; // int - years of the
    this.loanPeriodMonths = null; // int - months of the
    this.loanDownPayment = null;
    this.loanDisposableCommission = null;
    this.loanMonthlyCommission = null;
    this.loanLastPayment = null;
    this.loanSelectedCalc =
        0; // null - Annuity, 1 -  Differentiated, 2 - Fixed Payments
  }
}
