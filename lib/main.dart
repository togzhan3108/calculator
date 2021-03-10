// ID 26255
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  //Button Widget
  Widget calculator_button(String btn_txt, Color btn_color, Color txt_color){
    return  Container(
      child: RaisedButton(
        onPressed: (){
          calculation(btn_txt);
        },
        child: Text('$btn_txt',
          style: TextStyle(
            fontSize: 35,
            color: txt_color,
          ),
        ),
        color: btn_color,
        padding: EdgeInsets.all(20),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculator_button('AC',Colors.grey,Colors.black),
                calculator_button('+/-',Colors.grey,Colors.black),
                calculator_button('%',Colors.grey,Colors.black),
                calculator_button('/',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculator_button('7',Colors.grey[850],Colors.white),
                calculator_button('8',Colors.grey[850],Colors.white),
                calculator_button('9',Colors.grey[850],Colors.white),
                calculator_button('x',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculator_button('4',Colors.grey[850],Colors.white),
                calculator_button('5',Colors.grey[850],Colors.white),
                calculator_button('6',Colors.grey[850],Colors.white),
                calculator_button('-',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculator_button('1',Colors.grey[850],Colors.white),
                calculator_button('2',Colors.grey[850],Colors.white),
                calculator_button('3',Colors.grey[850],Colors.white),
                calculator_button('+',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //this is button Zero
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: (){
                    calculation('0');
                },
                  child: Text('0',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white),
                  ),
                  color: Colors.grey[850],
                ),
                calculator_button('.',Colors.grey[850],Colors.white),
                calculator_button('=',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text ='0';
  double number_1 = 0;
  double number_2 = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic oprtn = '';
  dynamic preOprtn = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      number_1 = 0;
      number_2 = 0;
      result = '';
      finalResult = '0';
      oprtn = '';
      preOprtn = '';

    } else if( oprtn == '=' && btnText == '=') {

      if(preOprtn == '+') {
        finalResult = addition();
      } else if( preOprtn == '-') {
        finalResult = substraction();
      } else if( preOprtn == 'x') {
        finalResult = multiplication();
      } else if( preOprtn == '/') {
        finalResult = division();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(number_1 == 0) {
        number_1 = double.parse(result);
      } else {
        number_2 = double.parse(result);
      }

      if(oprtn == '+') {
        finalResult = addition();
      } else if( oprtn == '-') {
        finalResult = substraction();
      } else if( oprtn == 'x') {
        finalResult = multiplication();
      } else if( oprtn == '/') {
        finalResult = division();
      }
      preOprtn = oprtn;
      oprtn = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = number_1 / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });

  }

  String addition() {
    result = (number_1 + number_2).toString();
    number_1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String substraction() {
    result = (number_1 - number_2).toString();
    number_1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String multiplication() {
    result = (number_1 * number_2).toString();
    number_1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String division() {
    result = (number_1 / number_2).toString();
    number_1 = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}
