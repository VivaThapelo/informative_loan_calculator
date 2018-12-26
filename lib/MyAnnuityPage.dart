import 'dart:core';

import 'package:flutter/material.dart';

import 'Loan.dart';
import 'Payment.dart';

class MyAnnuityPage extends StatefulWidget {
  final Loan loan;

  MyAnnuityPage({this.loan});

  MyAnnuityPageState createState() => MyAnnuityPageState();
}

class MyAnnuityPageState extends State<MyAnnuityPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('____ results'),
        bottom: new TabBar(
          tabs: [
            new Tab(
              text: "Data",
            ),
            new Tab(
              text: "Schedule",
            )
          ],
          controller: _tabController,
        ),
      ),
      body: new TabBarView(
        children: [
          new Column(
            children: <Widget>[
              new Card(
                child: new Container(
                  child: new Column(children: <Widget>[
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new Text('Loan amount'),
                          new Text(widget.loan.getAmount().toString())
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      padding: new EdgeInsets.all(4.0),
                    ),
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new Text('Nominal rate, %'),
                          new Text(widget.loan.getInterest().toString())
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      padding: new EdgeInsets.all(4.0),
                    ),
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new Text('Period'),
                          new Text(widget.loan.getPeriod().toString())
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      padding: new EdgeInsets.all(4.0),
                    ),
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new Text('Down payment'),
                          new Text(
                              widget.loan.getDownPaymentPayment().toString())
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      padding: new EdgeInsets.all(4.0),
                    ),
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new Text('Last payment'),
                          new Text(widget.loan.getResidue().toString())
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      padding: new EdgeInsets.all(4.0),
                    ),
                  ]),
                  padding: new EdgeInsets.all(8.0),
                ),
                color: Colors.white,
                margin: new EdgeInsets.all(16.0),
              ),
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Monthly payment',
                      style: new TextStyle(fontSize: 18.0),
                    ),
                    new Text(
                      widget.loan
                          .getMaxMonthlyPayment()
                          .toStringAsFixed(2)
                          .toString(),
                      style: new TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                padding: new EdgeInsets.all(4.0),
                margin: new EdgeInsets.all(16.0),
              ),
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Effective rate, %',
                      style: new TextStyle(fontSize: 18.0),
                    ),
                    new Text(
                      (widget.loan.getEffectiveInterestRate() * 50000)
                          .toString(),
                      style: new TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                padding: new EdgeInsets.all(4.0),
                margin: new EdgeInsets.all(16.0),
              ),
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Total Interest',
                      style: new TextStyle(fontSize: 18.0),
                    ),
                    new Text(
                      widget.loan.totalInterests.toStringAsFixed(2).toString(),
                      style: new TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                padding: new EdgeInsets.all(4.0),
                margin: new EdgeInsets.all(16.0),
              ),
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Commision total',
                      style: new TextStyle(fontSize: 18.0),
                    ),
                    new Text(
                      widget.loan
                          .getCommissionsTotal()
                          .toStringAsFixed(2)
                          .toString(),
                      style: new TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                padding: new EdgeInsets.all(4.0),
                margin: new EdgeInsets.all(16.0),
              ),
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Total amount(amount + interest)',
                      style: new TextStyle(fontSize: 18.0),
                    ),
                    new Text(
                      (widget.loan.getTotalAmount())
                          .toStringAsFixed(2)
                          .toString(),
                      style: new TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                padding: new EdgeInsets.all(4.0),
                margin: new EdgeInsets.all(16.0),
              ),
            ],
          ),
          new Container(
            child: new ListView.builder(
                itemCount: widget.loan.getPeriod(),
                itemBuilder: (context, position) {
                  List<Payment> payments = widget.loan.payments;
                  return new Container(
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Text(position.toString()), // Nr
                            new Text(payments[position]
                                .getBalance()
                                .toStringAsFixed(2)
                                .toString()), //Balance
                            new Text(payments[position]
                                .getPrincipal()
                                .toStringAsFixed(2)
                                .toString()), //Principal
                            new Text(payments[position]
                                .getInterest()
                                .toStringAsFixed(2)
                                .toString()), // Interest
                            new Text(payments[position]
                                .getAmount()
                                .toStringAsFixed(2)
                                .toString()) //Payment
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        )
                      ],
                    ),
                    margin: new EdgeInsets.all(16.0),
                  );
                }),
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
