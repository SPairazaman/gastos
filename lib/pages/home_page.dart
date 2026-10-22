import 'package:flutter/material.dart';
import 'package:gastos/db/db_helper_gastos.dart';
import 'package:gastos/models/gasto_model.dart';
import 'package:gastos/widgets/register_modal_widget.dart';
import 'package:gastos/widgets/card_widget.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Logger logger=Logger();
  List<GastoModel> gastosList = [];

  Future<void> getDataFromDB() async {
    gastosList = await DbHelperGastos.instance.getGastos();
    setState(() {});
  }

  Future<void> showRegisterModal() async {
    final result = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RegisterModalWidget(),
        );
      },
    );

     if (result == true) {
      getDataFromDB();
    }

  }

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showRegisterModal();
                  },
                  child: Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Agregar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Gastos',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Gestiona tus gastos de la mejor forma",
                          style: TextStyle(color: Colors.grey),
                        ),
                        
                        Expanded(
                          child: ListView.builder(
                            itemCount: gastosList.length,
                            itemBuilder: (BuildContext context,int index){
                                GastoModel gastoModel=gastosList[index];
                                return CardWidget(gastoModel: gastoModel);
                              },
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 90),
              ],
            ),
          ],
        ),
      ),
    );
  }
}