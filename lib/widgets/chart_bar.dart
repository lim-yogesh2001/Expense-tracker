import "package:flutter/material.dart";

class ChartBar extends StatelessWidget {
  final String lable;
  final double amount;
  final double pctSpendingAmount;

  ChartBar(this.lable, this.amount, this.pctSpendingAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: [
              FittedBox(
                  child: Text(
                'Rs.${amount.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
              )),
              SizedBox(
                height: constraint.maxHeight * 0.05,
              ),
              Container(
                height: constraint.maxHeight * 0.6,
                width: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade200, width: 1.0),
                          color: Color.fromRGBO(220, 220, 220, 1),
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    FractionallySizedBox(
                      heightFactor: pctSpendingAmount,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: constraint.maxHeight * 0.05,
              ),
              FittedBox(
                  child: Text(
                lable,
                style: TextStyle(fontSize: 12.0),
              ))
            ],
          ),
        );
      },
    );
  }
}
