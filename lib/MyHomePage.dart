import 'dart:core';

import 'package:flutter/material.dart';

import 'AnnuityCalculator.dart';
import 'DifferentiatedCalculator.dart';
import 'FixedPaymentCalculator.dart';
import 'Loan.dart';
import 'MyAnnuityPage.dart';

const int ANNUITY = 0, DIFFERENTIATED = 1, FIXED_PAYMENTS = 2;
Loan loaned = new Loan();
int downType = 0, lastType = 0, monthlyType = 0, disposableType = 0;
int selectedLoan = 0, selectedInterestType = 0;
int periodMonths = 0, periodYears = 0, period = 0;
String title = "Informative Loan Calculator";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _askedToLead() async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Form Data'),
            children: <Widget>[
              new Center(
                child: new Text(loaned.amount.toString() +
                    '\n' +
                    loaned.getInterest().toString() +
                    '\n' +
                    loaned.getDisposableCommission().toString()),
              ),

              /* SimpleDialogOption(
                onPressed: () { Navigator.pop(context, "close"); },
                child: const Text('Treasury department'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, "remove"); },
                child: const Text('State department'),
              ),*/
            ],
          );
        })) {
      case "close":
        new Text('close');
        break;
      case "remove":
        new Text('remove');
        break;
    }
  }

  TextEditingController _amountController = new TextEditingController();
  TextEditingController _interestController = new TextEditingController();
  TextEditingController _fixedPaymentController = new TextEditingController();
  TextEditingController _downPaymentController = new TextEditingController();
  TextEditingController _disposableCommissionController =
      new TextEditingController();
  TextEditingController _monthlyCommissionController =
      new TextEditingController();
  TextEditingController _lastPaymentController = new TextEditingController();

  clearForm() {
    setState(() {
      _amountController.text = '';
      _interestController.text = '';
      _fixedPaymentController.text = '';
      _downPaymentController.text = '';
      _disposableCommissionController.text = '';
      _monthlyCommissionController.text = '';
      _lastPaymentController.text = '';
      downType = 0;
      lastType = 0;
      monthlyType = 0;
      disposableType = 0;
      selectedLoan = 0;
      selectedInterestType = 0;
    });
  }

  clearAll() {
    clearForm(); // clearing the fields
    loaned.clearObject(); // clearing the class
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        actions: <Widget>[
          new RawMaterialButton(
              onPressed: () {
                clearAll();
              },
              child: new Text(
                'ClearAll',
                style: new TextStyle(fontSize: 18.0),
              ))
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        bottom: new PreferredSize(
            child: new ClipRRect(
              borderRadius: new BorderRadius.all(Radius.circular(16.0)),
              child: new Container(
                color: Colors.white,
                child: new DropdownButtonHideUnderline(
                    child: new DropdownButton(
                  value: selectedLoan,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        'Annuity Payments',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        'Differentiated',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                    new DropdownMenuItem(
                        child: new Text(
                          'Fixed Payments',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        value: 2)
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedLoan = value;
                    });
                  },
                  isExpanded: true,
                  hint: new Text(
                    'Select option:',
                    style: new TextStyle(fontSize: 18.0),
                  ),
                )),
                margin:
                    new EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                padding: new EdgeInsets.only(left: 16.0, right: 16.0),
              ),
            ),
            preferredSize: Size.fromHeight(56.0)),
        title: Text("Informative Loan Calculator"),
      ),
      body: new Container(
        padding: new EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
        child: new Column(children: [
          new TextField(
            decoration: new InputDecoration(
                labelText: "Loan Amount(R)",
                hintText: "e.g. 2000",
                helperText: "amount > 0"),
            controller: _amountController,
            onChanged: (amount) {
              loaned.setAmount(double.parse(amount));
            },
          ),
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 3,
                child: new DropdownButton(
                  value: selectedInterestType,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        'Nominal',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        'Effective',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedInterestType = value;
                    });
                  },
                  isExpanded: true,
                  hint: new Text(
                    'Type:',
                    style: new TextStyle(
                      fontSize: 18.0,
                      height: 3.8,
                    ),
                  ),
                ),
              ),
              new Flexible(
                flex: 7,
                child: new TextField(
                  controller: null,
                  decoration: new InputDecoration(
                    labelText: "Interest Rate(%)",
                    hintText: "5",
                    // helperText: "interest amount"
                  ),
                  onChanged: (interestPercentage) {
                    loaned.setInterestPercentage(
                        double.parse(interestPercentage));
                  },
                ),
              ),
            ],
          ),
          new TextField(
            decoration: new InputDecoration(
                labelText: "Fixed Payment",
                hintText: "e.g. 500",
                helperText: "amount > 0"),
            controller: _fixedPaymentController,
            onChanged: (fixedPayment) {
              loaned.setFixedPayment(double.parse(fixedPayment));
            },
          ),

          new Row(
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Text(
                  'Period:        ',
                  style: new TextStyle(fontSize: 18.0),
                ),
              ),
              new Flexible(
                flex: 3,
                child: new DropdownButton(
                  value: periodYears,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '0',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '1',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '2',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 2,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '3',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 3,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '4',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 4,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '5',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 5,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '6',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 6,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '7',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 7,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '8',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 8,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '9',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 9,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '10',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 10,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '11',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 11,
                    ),
                  ],
                  hint: new DropdownMenuItem(
                    child: new Text('Years'),
                    value: "Years",
                  ),
                  onChanged: (_periodYears) {
                    setState(() {
                      periodYears = _periodYears; // *12 is converting to months
                    });
                  },
                  isExpanded: true,
                ),
              ),
              new Flexible(
                flex: 3,
                child: new DropdownButton(
                    value: periodMonths,
                    items: [
                      new DropdownMenuItem(
                        child: new Text(
                          '0',
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        value: 0,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '1',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        value: 1,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '2',
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        value: 2,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '3',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        value: 3,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '4',
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        value: 4,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '5',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        value: 5,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '6',
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        value: 6,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '7',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        value: 7,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '8',
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        value: 8,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '9',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        value: 9,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '10',
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        value: 10,
                      ),
                      new DropdownMenuItem(
                        child: new Text(
                          '11',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        value: 11,
                      ),
                    ],
                    onChanged: (_periodMonths) {
                      setState(() {
                        periodMonths = _periodMonths;
                      });
                    },
                    isExpanded: true,
                    hint: new DropdownMenuItem(
                      child: new Text('Months'),
                      value: "Months",
                    )),
              ),
            ],
          ),

          ///// the ones at the bottom ---- add margin/padding at top by 16.0

          // Down Payment
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 8,
                child: new TextField(
                  controller: _downPaymentController,
                  decoration: new InputDecoration(
                      labelText: "Down Payment",
                      hintText: "e.g. 400",
                      helperText: "value or percentage from loan amount"),
                  onChanged: (downPayment) {
                    loaned.setDownPayment(
                        double.parse(downPayment)); // executes the storing code
                  },
                ),
              ),
              new Flexible(
                flex: 2,
                child: new DropdownButton(
                  value: loaned.getDownPaymentType(),
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '%',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '.00',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                  ],
                  hint: new DropdownMenuItem(
                    child: new Text('%'),
                    value: "%",
                  ),
                  onChanged: (downPaymentType) {
                    setState(() {
                      loaned.setDownPaymentType(downPaymentType);
                    });
                    // executes the storing code
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),

          // Disposable Commission
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 8,
                child: new TextField(
                  controller: null,
                  decoration: new InputDecoration(
                      labelText: "Disposable Commission",
                      hintText: "e.g. 200",
                      helperText: "value or percentage from loan amount"),
                  onChanged: (disposableCommission) {
                    loaned.setDisposableCommission(
                        double.parse(disposableCommission));
                  },
                ),
              ),
              new Flexible(
                flex: 2,
                child: new DropdownButton(
                  value: loaned.getDisposableCommissionType(),
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '%',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '.00',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                  ],
                  hint: new DropdownMenuItem(
                    child: new Text('%'),
                    value: "%",
                  ),
                  onChanged: (disposableCommissionType) {
                    setState(() {
                      loaned.setDisposableCommissionType(
                          disposableCommissionType);
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),

          // Monthly Commission
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 8,
                child: new TextField(
                  controller: null,
                  decoration: new InputDecoration(
                      labelText: "Monthly Commission",
                      hintText: "e.g. 150",
                      helperText:
                          "value or percentage from monthly commission"),
                  onChanged: (monthlyCommission) {
                    loaned
                        .setMonthlyCommission(double.parse(monthlyCommission));
                  },
                ),
              ),
              new Flexible(
                flex: 2,
                child: new DropdownButton(
                  value: loaned.getMonthlyCommissionType(),
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '%',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '.00',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                  ],
                  hint: new DropdownMenuItem(
                    child: new Text('%'),
                    value: "%",
                  ),
                  onChanged: (monthlyCommissionType) {
                    setState(() {
                      loaned.setMonthlyCommissionType(monthlyCommissionType);
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),

          // Last Payment
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 8,
                child: new TextField(
                  controller: null,
                  decoration: new InputDecoration(
                      labelText: "Last Payment",
                      hintText: "e.g. 350",
                      helperText: "value or percentage from month"),
                  onChanged: (residue) {
                    loaned.setResidue(double.parse(residue));
                  },
                ),
              ),
              new Flexible(
                flex: 2,
                child: new DropdownButton(
                  value: loaned.getResidueType(),
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '%',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '.00',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                  ],
                  hint: new DropdownMenuItem(
                    child: new Text('%'),
                    value: "%",
                  ),
                  onChanged: (residueType) {
                    setState(() {
                      loaned.setResidueType(residueType);
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          loaned.setPeriod(periodMonths + periodYears * 12);

          /// this is for making sure that period adds up
          if (selectedLoan == 0) {
            // Annuity
            AnnuityCalculator AnClc = new AnnuityCalculator();
            AnClc.calculate(loaned);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyAnnuityPage(
                        loan: loaned,
                      )),
            );
            print("What's happening here?");
          } else if (selectedLoan == 1) {
            // Differentiated
            DifferentiatedCalculator DiffClc = new DifferentiatedCalculator();
            DiffClc.calculate(loaned);
          } else if (selectedLoan == 2) {
            // Fixed payments
            FixedPaymentCalculator FixedClc = new FixedPaymentCalculator();
            FixedClc.calculate(loaned);
          }
        },
        tooltip: 'Calculate',
        icon: Icon(Icons.done),
        label: new Text('Calculate'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
