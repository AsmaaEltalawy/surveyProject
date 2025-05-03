import 'package:flutter/material.dart';
import 'package:surveypro/models/stat_card_model.dart';
class CardsStyle extends StatelessWidget {
  StatCardsModel cardModel;
  CardsStyle(this.cardModel);
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: cardModel.icon,
              ),
    ]
          ),
          SizedBox(height: 5),
          Text(
            cardModel.description?? "NAN",
            style: theme.textTheme.titleMedium
          ),
          SizedBox(height: 4),
          Text(
            cardModel.result.toString(),
            style: theme.textTheme.bodyMedium
          ),
        ],
      ),
    );
  }
}