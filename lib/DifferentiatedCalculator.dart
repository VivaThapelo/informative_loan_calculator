import 'Loan.dart';
import 'Payment.dart';
import 'AbstractCalc.dart';

class DifferentiatedCalculator extends AbstractCalc {
  final double TWO = 2;

  void calculate(Loan loan) {
    double amount = calculateAmountWithDownPayment(loan);
    loan.setResiduePayment(getResiduePayment(loan));
    bool hasResidue = loan.getResiduePayment().compareTo(0) > 0;
    addDisposableCommission(loan, amount);

    double interestMonthly = loan.getInterest() / 1200;
    int period = hasResidue ? loan.getPeriod() - 1 : loan.getPeriod();
    double residueInterest =
        hasResidue ? loan.getResiduePayment() * interestMonthly : 0;

    double monthlyAmount =
        (amount - loan.getResiduePayment()) / period.toDouble();
    double currentAmount = amount;
    List<Payment> payments = new List<Payment>();
    int i = 0;
    for (; i < period; i++) {
      double interest = currentAmount * interestMonthly;
      double payment = interest + monthlyAmount;

      Payment p = new Payment();
      p.setNr(i + 1);
      p.setInterest(interest);
      p.setPrincipal(monthlyAmount);
      p.setBalance(currentAmount);

      addPaymentWithCommission(loan, p, payment);

      payments.add(p);

      currentAmount = currentAmount - monthlyAmount;
    }
    if (hasResidue) {
      double payment = loan.getResiduePayment();
      double principal = payment;
      Payment p = new Payment();
      p.setNr(i + 1);
      p.setBalance(currentAmount);
      p.setInterest(residueInterest);
      p.setPrincipal(principal);

      addPaymentWithCommission(loan, p, payment + residueInterest);

      payments.add(p);
      currentAmount = currentAmount - principal;
    }
    loan.setPayments(payments);
    loan.setEffectiveInterestRate(calculateEffectiveInterestRate(loan));
  }
}
