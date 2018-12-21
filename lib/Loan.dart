import 'dart:math';

import 'Payment.dart';

class Loan {
  int PERCENT = 0;
  int VALUE = 1;

  bool calculated;
  int loanType = 0; // null - Annuity, 1 -  Differentiated, 2 - Fixed Payments
  double amount;
  int interestType = 0; // 0 - Nominal , 2 - Effective
  double interest;
  double fixedPayment;
  int period = 0;
  List<Payment> payments = new List<Payment>();

  double totalInterests = 0;
  double minimalPayment = 0;
  double maximalPayment = 0;

  double downPayment;
  double disposableCommission;
  double monthlyCommission;
  double residue;

  int downPaymentType;
  int disposableCommissionType;
  int monthlyCommissionType;
  int residueType;

  double downPaymentPayment;
  double disposableCommissionPayment;
  double monthlyCommissionPayment;
  double residuePayment;

  double commissionsTotal = 0;

  double effectiveInterestRate = 0;

  Loan();

  void setPayments(List<Payment> payments) {
    this.payments = payments;
    totalInterests = 0;
    minimalPayment = 0;
    maximalPayment = 0;
    commissionsTotal = 0;

    if (disposableCommissionPayment != null) {
      commissionsTotal += disposableCommissionPayment;
    }

    int i = 0;
    for (Payment payment in payments) {
      totalInterests += payment.getInterest();

      if (payment.getCommission() != null) {
        commissionsTotal += payment.getCommission();
      }

      if (++i != payments.length || getResidue().compareTo(0.0) == 0) {
        if (minimalPayment == 0.0) {
          minimalPayment = payment.getAmount();
        } else {
          minimalPayment = min(minimalPayment, (payment.getAmount()));
        }
        maximalPayment = max(maximalPayment, (payment.getAmount()));
      }
    }
  }

  double getTotalAmount() {
    double total = amount + totalInterests;

    if (getCommissionsTotal() != null &&
        getCommissionsTotal().compareTo(0) != 0) {
      total = total + getCommissionsTotal();
    }
    return total;
  }

  int getLoanType() {
    return loanType;
  }

  void setLoanType(int loanType) {
    this.loanType = loanType;
  }

  double getMonthlyCommission() {
    return monthlyCommission;
  }

  double getTotalInterests() {
    return totalInterests;
  }

  double getMaxMonthlyPayment() {
    return maximalPayment;
  }

  double getMinMonthlyPayment() {
    return minimalPayment;
  }

  double getAmount() {
    return amount;
  }

  double getInterest() {
    return interest;
  }

  int getPeriod() {
    return period;
  }

  List<Payment> getPayments() {
    // return new List<Payment>(payments); consider
    return payments;
  }

  double getFixedPayment() {
    return fixedPayment;
  }

  setAmount(double amount) {
    this.amount = amount;
  }

  setInterestType(int type) {
    this.interestType = type;
  }

  setInterestPercentage(double interest) {
    this.interest = interest;
  }

  setFixedPayment(double fixedPayment) {
    this.fixedPayment = fixedPayment;
  }

  setPeriod(int period) {
    this.period += period; // stored in months
  }

  double getDisposableCommission() {
    return disposableCommission;
  }

  double getDownPayment() {
    return downPayment;
  }

  void setDownPaymentPayment(double downPaymentPayment) {
    this.downPaymentPayment = downPaymentPayment;
  }

  int getDownPaymentType() {
    return downPaymentType;
  }

  void setDownPaymentType(int downPaymentType) {
    this.downPaymentType = downPaymentType;
  }

  int getDisposableCommissionType() {
    return disposableCommissionType;
  }

  int getMonthlyCommissionType() {
    return monthlyCommissionType;
  }

  double getDownPaymentPayment() {
    return downPaymentPayment;
  }

  double getMonthlyCommissionPayment() {
    return monthlyCommissionPayment;
  }

  setDownPayment(double downPayment) {
    this.downPayment = downPayment;
  }

  void setDisposableCommissionType(int disposableCommissionType) {
    this.disposableCommissionType = disposableCommissionType;
  }

  void setMonthlyCommissionType(int monthlyCommissionType) {
    this.monthlyCommissionType = monthlyCommissionType;
  }

  double getDisposableCommissionPayment() {
    return disposableCommissionPayment;
  }

  void setDisposableCommissionPayment(double disposableCommissionPayment) {
    this.disposableCommissionPayment = disposableCommissionPayment;
  }

  void setEffectiveInterestRate(double effectiveInterestRate) {
    this.effectiveInterestRate = effectiveInterestRate;
  }

  double getCommissionsTotal() {
    return commissionsTotal;
  }

  double getEffectiveInterestRate() {
    return effectiveInterestRate;
  }

  double getResiduePayment() {
    return residuePayment;
  }

  int getResidueType() {
    return residueType;
  }

  void setResidueType(int residueType) {
    this.residueType = residueType;
  }

  double getResidue() {
    return residue;
  }

  setDisposableCommission(double disposableCommission) {
    this.disposableCommission = disposableCommission;
  }

  setMonthlyCommission(double monthlyCommission) {
    this.monthlyCommission = monthlyCommission;
  }

  setResiduePayment(double lastPayment) {
    this.residue = lastPayment;
  }

  void setResidue(double residue) {
    this.residue = residue;
  }

  bool hasDownPayment() {
    return getDownPaymentPayment() != null &&
        getDownPaymentPayment().compareTo(0) > 0;
  }

  bool hasDisposableCommission() {
    return getDisposableCommissionPayment() != null &&
        getDisposableCommissionPayment().compareTo(0) > 0;
  }

  bool hasAnyCommission() {
    return getCommissionsTotal().compareTo(0) > 0;
  }

  bool isCalculated() {
    return calculated;
  }

  void setCalculated(bool calculated) {
    this.calculated = calculated;
  }

  clearObject() {
    this.amount = null;
    this.interestType = null; // 0 - Nominal , 2 - Effective
    this.interest = null;
    this.fixedPayment = null;
    this.period = null; // int - months of the
    this.downPayment = null;
    this.disposableCommission = null;
    this.monthlyCommission = null;
    this.residue = null;
    this.loanType =
        0; // null - Annuity, 1 -  Differentiated, 2 - Fixed Payments
  }
}
