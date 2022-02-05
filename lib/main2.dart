import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const buttonsize = 60.0;
  final _con = TextEditingController();
  String _input = "";
  String _output = "ทายเลข 1 ถึง 100";
  var game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.5),
                blurRadius: 5.0,
                offset: const Offset(1.0, 1.0),
                spreadRadius: 5.0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 100.0),
                    const SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GUESS',
                          style: TextStyle(
                            fontSize: 36.0,
                            color: Colors.purple.shade200,
                          ),
                        ),
                        const Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.purple,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _input,
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(1),
                      _button(2),
                      _button(3),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(4),
                      _button(5),
                      _button(6),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(7),
                      _button(8),
                      _button(9),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(-2),
                      _button(0),
                      _button(-1),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () {
                    int? inp = int.tryParse(_input);

                    var a = game.doGuess(inp!);
                    print(a);
                    setState(() {
                      if (a ==1) {//>
                        _output = "$_input : มากเกินไป";
                        _input = "";
                      } else if (a==-1) {//<
                        _output = "$_input : น้อยเกินไป";
                        _input = "";
                      } else {//==
                        _output = "$_input : ถูกต้อง(ทาย ${game.guessCount} ครั้ง)";
                      }
                    });

                  },
                  child: const Text('GUESS',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _button(int num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {

        },
        borderRadius: BorderRadius.circular(30.0),
        child: OutlinedButton(
          onPressed: (){
            if(num==-2){
              setState(() {
                _input = "";
              });
            }
            else if (num == -1) {
              setState(() {
                var len = _input.length;
                _input = _input.substring(0,len-1);
              });
            } else {
              setState(() {
                if(_input.length<=2) {
                  _input = "$_input$num";
                }
              });
            }
          },

          child: (num == -1) ? Icon(Icons.backspace_outlined) :(num==-2)?Icon(Icons.close): Text("$num"),
        ),
      ),
    );
  }
}
