
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
//import 'home_page.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage>
    with SingleTickerProviderStateMixin {
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();

   final TextEditingController _teamAPlayer1Controller = TextEditingController();
  final TextEditingController _teamAPlayer2Controller = TextEditingController();
  final TextEditingController _teamBPlayer1Controller = TextEditingController();
  final TextEditingController _teamBPlayer2Controller = TextEditingController();
  bool _isAnimating = false;
  double _buttonWidth = 200;
  Color _buttonColor = Colors.blue;
   String _mode = 'solo';

  void _navigateToScoreboard() {
    final teamAName = _teamAController.text;
    final teamBName = _teamBController.text;
     String teamAPlayer1 = _teamAPlayer1Controller.text.trim();
    String teamBPlayer1 = _teamBPlayer1Controller.text.trim();
    String? teamAPlayer2;
    String? teamBPlayer2;


 if (_mode == 'duo') {
      teamAPlayer2 = _teamAPlayer2Controller.text.trim();
      teamBPlayer2 = _teamBPlayer2Controller.text.trim();
    }

    if (teamAName.isNotEmpty && teamBName.isNotEmpty && teamAPlayer1.isNotEmpty && teamBPlayer1.isNotEmpty) {
      setState(() {
        _isAnimating = true;
        _buttonWidth = 250;
        _buttonColor = Colors.green;
      });

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isAnimating = false;
          _buttonWidth = 200;
          _buttonColor = Colors.blue;
        });
         Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            teamAName: teamAName,
            teamBName: teamBName,
            teamAPlayer1: teamAPlayer1,
            teamAPlayer2: _mode == 'duo' ? teamAPlayer2 : null,
            teamBPlayer1: teamBPlayer1,
            teamBPlayer2: _mode == 'duo' ? teamBPlayer2 : null,
          ),
        ),
      );

/*
        Navigator.pushNamed(
          context,
          '/home',
          arguments: {'teamAName': teamAName, 'teamBName': teamBName},
        );
        */
      });
    } else {
      // Show a snackbar or any other UI to inform the user to enter both names
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter Valid Information')),
      );
    }
  }

//animation
 bool _firstImage = true;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }
 void _startAnimation() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _firstImage = !_firstImage;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Scaffold(
      body:AnimatedContainer(
         height: 1000,
        width: double.infinity,
        duration: Duration(seconds: 5),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              _firstImage ? 'assets/background.jpg' : 'assets/background2.webp',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child:
           SingleChildScrollView(
       // fit: StackFit.expand,
       
        child: 
        
          Padding(
            
            padding: const EdgeInsets.all(16.0),
            
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40,),
                Center(
                  child: Text(
                    "Welcome Back...!",
                     style: GoogleFonts.dancingScript(
                  textStyle: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 6, 89),
                  ),
                ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  style: TextStyle(color: Colors.white,fontSize: 25),
                  controller: _teamAController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 24, 22, 22).withOpacity(0.8),
                    labelText: 'Enter Team A Name',
                     labelStyle: TextStyle(
                    color: Colors.blue, // Label text color
                    fontSize: 16, // Label text size
                    fontWeight: FontWeight.bold, // Label text weight
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  cursorColor: Colors.blue,
                   style: TextStyle(color: Colors.white,fontSize: 25),
                  controller: _teamBController,
                  decoration: InputDecoration(
                    filled: true,
                   // fillColor: Colors.white.withOpacity(0.8),
                     fillColor: Color.fromARGB(255, 24, 22, 22).withOpacity(0.8),
                    labelText:('Enter Team B Name'),
                    
                     labelStyle: TextStyle(
                    color:Colors.blue, // Label text color
                    fontSize: 16, // Label text size
                    fontWeight: FontWeight.bold, // Label text weight
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Select the mode",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text('Solo',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      leading: Radio<String>(
                        value: 'solo',
                        groupValue: _mode,
                        onChanged: (String? value) {
                          setState(() {
                            _mode = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Duo',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      leading: Radio<String>(
                        value: 'duo',
                        groupValue: _mode,
                        onChanged: (String? value) {
                          setState(() {
                            _mode = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              
               
              SizedBox(height: 20),
              if (_mode == 'solo' || _mode == 'duo') ...[
                Row(
                  children: <Widget>[
                   // if (_mode == 'solo')
                    Expanded(
                      child: TextField(
                       style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
                        controller: _teamAPlayer1Controller,
                        decoration: InputDecoration(
                          labelText: 'Team A Player Name',
                          
                          labelStyle: TextStyle(
                           // backgroundColor: Colors.white,
                    color: Colors.blue, // Label text color
                    fontSize: 16, // Label text size
                    fontWeight: FontWeight.bold, // Label text weight
                  ),
                        ),
                      ),
                    ),
                   // if (_mode == 'solo')
                      SizedBox(width: 2.5),
                      Text("Vs",style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),),
                       SizedBox(width: 5),
                    //if (_mode == 'solo')
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
                          controller: _teamBPlayer1Controller,
                          decoration: InputDecoration(
                            
                            labelText: 'Team B Player  Name',
                            labelStyle: TextStyle(
                    color: Colors.blue, // Label text color
                    fontSize: 16, // Label text size
                    fontWeight: FontWeight.bold, // Label text weight
                  ),
                          ),
                        ),
                      ),
                  ],
                ),
              SizedBox(height: 20),
               Row(
                  children: <Widget>[
                    if (_mode == 'duo')
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
                        controller: _teamAPlayer2Controller,
                        decoration: InputDecoration(
                          labelText: 'Team A Player Name 2',
                          labelStyle: TextStyle(
                    color: Colors.blue, // Label text color
                    fontSize: 16, // Label text size
                    fontWeight: FontWeight.bold, // Label text weight
                  ),
                        ),
                      ),
                    ),
                    if (_mode == 'duo')
                     // SizedBox(width: 10),
                      SizedBox(width: 2.5),
                       if (_mode == 'duo')
                      Text("Vs",style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),),
                       SizedBox(width: 5),
                    if (_mode == 'duo')
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
                          controller: _teamBPlayer2Controller,
                          decoration: InputDecoration(
                            labelText: 'Team B Player 2 Name',
                            labelStyle: TextStyle(
                    color: Colors.blue, // Label text color
                    fontSize: 16, // Label text size
                    fontWeight: FontWeight.bold, // Label text weight
                  ),
                          ),
                        ),
                      ),
                  ],
                ),
             
                SizedBox(height: 20),
                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _buttonWidth,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColor,
                      ),
                      onPressed: _navigateToScoreboard,
                      child: _isAnimating
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Start Match',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                    ),
                  ),
                ),
              ],
            ]),
          
        ),
      ),
      ), 
    
    ) );
  
  }
}

