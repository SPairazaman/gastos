import 'package:flutter/material.dart';
import 'package:gastos/data_general.dart';
import 'package:gastos/db/db_helper_gastos.dart';
import 'package:gastos/models/gasto_model.dart';
import 'package:gastos/widgets/field_widget.dart';
import 'package:gastos/widgets/item_type_widget.dart';

class RegisterModalWidget extends StatefulWidget {
  RegisterModalWidget({super.key});

  @override
  State<RegisterModalWidget> createState() => _RegisterModalWidgetState();
}

class _RegisterModalWidgetState extends State<RegisterModalWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  String typeSelected = "Alimentos";

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            addGasto();
          }
        },
        child: Text("Guardar", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void addGasto(){
    GastoModel gastoModel= GastoModel(
      title: _titleController.text.trim(), 
      price: double.tryParse(_priceController.text.trim())?? 0.0, 
      dateTime: _dateController.text.trim(), 
      type: typeSelected,
    );
    DbHelperGastos.instance.insertGasto(gastoModel).then((res){
      if(res>0){
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.cyan,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            content: Row(
              children: [
                Icon(Icons.check_circle,color:Colors.white),
                SizedBox(width: 10,),
                Text("Gasto registrado..."),
              ],
            ),
          ),
        );
        Navigator.pop(context, true);
      }
    });
  }

  void showSelectorFecha() async {
    DateTime? selectDay = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
      helpText: "Selecciona una fecha",
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      fieldHintText: "dd/mm/aaaa",
      fieldLabelText: "Fecha",
      // Para deshabilitar algunos días
     /*  selectableDayPredicate: (day) {
        return day.weekday != DateTime.sunday;
      }, */
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.cyan, 
              onPrimary: Colors.red, 
              onSurface: Colors.blue,
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(45),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectDay != null) {
      _dateController.text =
          "${selectDay.day}/${selectDay.month}/${selectDay.year}";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Registra tu pago", style: TextStyle(fontSize: 22)),
              SizedBox(height: 12),
              FieldWidget(
                controller: _titleController,
                hintText: "Ingresa el nombre del gasto",
                validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "El nombre es obligatorio";
                    } else {
                      return null;
                    }
                }),
              ),
              FieldWidget(
                controller: _priceController,
                hintText: "Ingresa el monto",
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "El monto es obligatorio";
                    } else {
                      return null;
                    }
                }),
              ),
              FieldWidget(
                controller: _dateController,
                hintText: "Ingresa la fecha",
                function: showSelectorFecha,
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "La fecha es obligatoria";
                    } else {
                      return null;
                    }
                }),
              ),
          
              Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: types
                      .map(
                        (type) => ItemTypeWidget(
                          data: type,
                          isSelected: typeSelected == type["name"] ? true : false,
                          tap: () {
                            typeSelected = type["name"];
                            setState(() {});
                          },
                        ),
                      )
                      .toList(),
                ),
          
              SizedBox(height: 8),
          
              _buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }
}