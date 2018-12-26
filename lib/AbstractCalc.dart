import 'dart:core';
import 'dart:math';

import 'package:informative_loan_calculator/Calc.dart';

import 'Loan.dart';
import 'Payment.dart';

abstract class AbstractCalc implements Calc {

  static final double B100 = 100;

  void addPaymentWithCommission(Loan loan, Payment p, double payment) {
    double monthlyCommission = loan.getMonthlyCommission();
    if (monthlyCommission != null && monthlyCommission.compareTo(0) != 0) {
      if (loan.getMonthlyCommissionType() == loan.PERCENT) {
        monthlyCommission = (monthlyCommission * payment) / B100;
      }
      p.setCommission(monthlyCommission);
      p.setAmount(payment + monthlyCommission);
    } else {
      p.setAmount(payment);
    }
  }

  void addDisposableCommission(Loan loan, double amount) {
    double disposableCommission = loan.getDisposableCommission();
    if (disposableCommission != null &&
        disposableCommission.compareTo(0) != 0) {
      if (loan.getDisposableCommissionType() == loan.PERCENT) {
        disposableCommission = (disposableCommission * amount) / B100;
      }
      loan.setDisposableCommissionPayment(disposableCommission);
    }
  }

  double calculateAmountWithDownPayment(Loan loan) {
    double amount = loan.getAmount();

    double downPayment = loan.getDownPayment();
    if (downPayment != null && downPayment.compareTo(0) != 0) {
      if (loan.getDownPaymentType() == loan.PERCENT) {
        downPayment = (downPayment * amount) / B100;
      }
      loan.setDownPaymentPayment(downPayment);
      amount = amount - downPayment;
    }
    return amount;
  }

  /**
   * Calculation of effective rate of loan using iterative approach: <br /><br />
   * <code>loanAmount = SUM(i=1 to i=payments.length) { payments[i] / (( 1 + effectiveRate ) ^ (i/12)) }</code>
   * <br /><br />
   * <li>https://www.riigiteataja.ee/akt/13363716</li>
   * <li>https://www.riigiteataja.ee/aktilisa/0000/1336/3716/13363719.pdf</li>
   * @param loan Loan
   * @return Effective rate
   */
  double calculateEffectiveInterestRate(Loan loan) {
    double loanAmount = loan.getAmount().toDouble() -
        (loan.getDownPaymentPayment() != null ? loan.getDownPaymentPayment()
            .toDouble() : 0) -
        (loan.getDisposableCommissionPayment() != null ? loan
            .getDisposableCommissionPayment().toDouble() : 0);
    double realInterest = loan.getInterest().toDouble() / 100;

    List<double> payments = <double>[loan.getPeriod().toDouble()];
    int i = 0;
    for (Payment payment in loan.getPayments()) {
      try {
        payments[i++] = payment.getAmount().toDouble();
      } catch (e) {
        print(e);
      }
    }

    double x = calcEffRateUsingIterativeApproach(
        realInterest, loanAmount, payments, 1);
    return x * 100;
  }

  /**
   *
   * @param realInterest Real interest rates, using it only for choosing right start and end points
   * @param loanAmount  Loan amount
   * @param payments Payments
   * @param periodBetweenPayments months between payments, usually is it 1
   * @return effective rate
   */
  double calcEffRateUsingIterativeApproach(double realInterest,
      double loanAmount, List<double> payments, int periodBetweenPayments) {
    int i;
    double x1 = 0;
    double x2 = realInterest * 10; // x10 greater
    double lastKnownX = 0;
    for (i = 0; i < 100; i++) { // max 100 iterations
      double x = (x1 + x2) / 2; //average
      if ((lastKnownX * 100000).round() == (x * 100000).round()) {
        print("Done in " + i.toString() + " iterations");
        break; // breaks iterations then accuracy is 2 symbols after coma
      }
      lastKnownX = x;
      double a = calcLoanAmountUsingEffectiveRate(
          payments, x, periodBetweenPayments);

      if (loanAmount < a) {
        x1 = x;
      }
      else {
        x2 = x;
      }
    }
    return (x1 + x2) / 2;
  }

  /**
   * Calculate amount using effective rate and payments
   * @param payments Payments
   * @param effectiveRate Effective Rate
   * @param periodBetweenPayments months between payments, usually is it 1
   * @return loan amount
   */
  double calcLoanAmountUsingEffectiveRate(List<double> payments,
      double effectiveRate, int periodBetweenPayments) {
    double result = 0;

    for (int i = 0; i < payments.length; i++) {
      result += payments[i] / (pow(
          1 + effectiveRate, (i + 1).toDouble() * periodBetweenPayments / 12));
    }

    return result;
  }


  double getResiduePayment(Loan loan) {
    bool hasResidue = loan.getResidue() != null &&
        loan.getResidue().compareTo(0) > 0;
    if (hasResidue) {
      return loan.getResidueType() == loan.PERCENT ? (loan.getAmount() *
          loan.getResidue()) / B100 : loan.getResidue();
    } else {
      return 0;
    }
  }
}