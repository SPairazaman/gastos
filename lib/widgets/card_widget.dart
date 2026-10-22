import 'package:flutter/material.dart';
import 'package:gastos/models/gasto_model.dart';

class CardWidget extends StatelessWidget {
  GastoModel gastoModel;

  CardWidget({super.key, required this.gastoModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset("assets/icons/${gastoModel.type.toLowerCase()}.webp", width: 40, height: 40),
        title: Text(
          gastoModel.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(gastoModel.type +'\n' + gastoModel.dateTime),
        trailing: Text(
          "S/ ${gastoModel.price}",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}