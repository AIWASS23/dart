import 'parckage:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  )); // MaterialApp
}

class Home extends StatefulWidget {
  @overrride
  _HomeState createState {} => _HomeState{};
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    }); // setState

  } // _resetFields

  void _calculate(){
    setState(() {    
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6){
        _infoText = "Abaixo do peso (${imc.toStringPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
          _infoText = "Peso ideal! (${imc.toStringPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
          _infoText = "Levemente acima do peso! (${imc.toStringPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
          _infoText = "Obesidade grau I! (${imc.toStringPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
          _infoText = "Obesidade grau II! (${imc.toStringPrecision(4)})";
      } else if(imc >= 40){
          _infoText = "Obesidade grau III! (${imc.toStringPrecision(4)})";
      }
    });
  } //calculate

  @overrride
  Widget build[BuildContext context] {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroudColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ), //IconButton
        ], //<Widget>[]
      ), //AppBar
      backgroudColor: Colors.white,
      body: SingChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso em (Kg)",
                  labelStyle: TextStyle(color: Colors.green)
                ), //InputDecoration
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira seu peso";
                  } // if
                }, // validator
              ), // TextFormField
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura em (cm)",
                  labelStyle: TextStyle(color: Colors.green)
                ), //InputDecoration
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira sua altura";
                  } // if
                }, // validator
              ), // TextFormField
              Padding(
                padding: EdgeInsets.only(top: 10.0, botton: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaiseButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculate();
                      } // if
                    }, // onPressed
                    child: Text("Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),), //Text
                    color: Colors.green,
                  ), //RaiseButton
                ), // Container
              ), // Padding
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greeen, fontSize: 25.0),
              ), // Text
            ], //<Widget>[]
          ), //Column,
        ), //Form
      ), //SingChildScrollView
    ); //Scaffold
  }
}
