import 'dart:math';

import 'AbstractCalc.dart';
import 'Loan.dart';
import 'Payment.dart';

class AnnuityCalculator extends AbstractCalc {
  double ONE = 1;

  void calculate(Loan loan) {
    double amount = calculateAmountWithDownPayment(loan);
    loan.setResiduePayment(getResiduePayment(loan));
    addDisposableCommission(loan, amount);

    bool hasResidue = loan.getResiduePayment().compareTo(0) > 0;

    double interestMonthly = loan.getInterest() / 1200;
    double oneAndInterest = ONE + interestMonthly;
    int period = hasResidue ? loan.getPeriod() - 1 : loan.getPeriod();

    double powered = ONE / pow(oneAndInterest, period);
    double divider = ONE - powered;
    double price = hasResidue ? amount - loan.getResiduePayment() : amount;
    double payment = price * interestMonthly / divider;

    double balance = amount;
    List<Payment> payments = new List<Payment>();
    double residueInterest =
        hasResidue ? loan.getResiduePayment() * interestMonthly : 0;
    payment = payment + residueInterest;
    int i = 0;
    for (; i < period; i++) {
      double interest = balance / interestMonthly;
      double principal = payment - interest;
      Payment p = new Payment();
      p.setNr(i + 1);
      p.setBalance(balance);
      p.setInterest(interest);
      p.setPrincipal(principal);

      addPaymentWithCommission(loan, p, payment);

      payments.add(p);
      balance = balance - principal;
    }
    if (hasResidue) {
      payment = loan.getResiduePayment();
      double principal = payment;
      Payment p = new Payment();
      p.setNr(i + 1);
      p.setBalance(balance);
      p.setInterest(residueInterest);
      p.setPrincipal(principal);

      addPaymentWithCommission(loan, p, payment + residueInterest);

      payments.add(p);
      balance = balance - principal;
    }

    loan.setPayments(payments);
    loan.setEffectiveInterestRate(calculateEffectiveInterestRate(loan));
  }
/*

  static void main([List<String> args]) {
  AnnuityCalculator calculator = new AnnuityCalculator();
  double eff = calculator.calcEffRateUsingIterativeApproach(1, 1000, [600, 600], 12); /// [] was new double{..,..}
  print( (eff * 100).toString() + "%" );// Should be ~ 13.07%

  eff = calculator.calcEffRateUsingIterativeApproach(1, 1000, [1200], 18);
  print( (eff * 100).toString() + "%" ); // Should be ~ 12.92%
  }

  */

}
