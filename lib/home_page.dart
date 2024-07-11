import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
class HomePage extends StatefulWidget {
  final String teamAName;
  final String teamBName;
  final String teamAPlayer1;
  final String? teamAPlayer2;
  final String teamBPlayer1;
  final String? teamBPlayer2;

  HomePage({
    required this.teamAName,
     required this.teamBName,
      required this.teamAPlayer1,
    this.teamAPlayer2,
    required this.teamBPlayer1,
    this.teamBPlayer2,
     });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int teamAScore = 0;
  int teamBScore = 0;
  String resultMessage = '';
  bool showAnimation = false;

  void _incrementScoreA() {
    setState(() {
      teamAScore++;
    });
  }

  void _decrementScoreA() {
    setState(() {
      if (teamAScore > 0) teamAScore--;
    });
  }

  void _incrementScoreB() {
    setState(() {
      teamBScore++;
    });
  }

  void _decrementScoreB() {
    setState(() {
      if (teamBScore > 0) teamBScore--;
    });
  }

  void _matchComplete() {
    setState(() {
      if (teamAScore > teamBScore) {
        resultMessage = '${widget.teamAName} won the match';
      } else if (teamBScore > teamAScore) {
        resultMessage = '${widget.teamBName} won the match';
      } else {
        resultMessage = 'It\'s a tie';
      }
      showAnimation = true;
    });
  }

  void _resetScores() {
    setState(() {
      teamAScore = 0;
      teamBScore = 0;
      resultMessage = '';
      showAnimation = false;
    });
  }
  
  void _showTeamDetails(String teamName, String player1, String? player2) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$teamName Team Details',style: TextStyle(color: Colors.blue),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Player 1: $player1'),
              if (player2 != null) Text('Player 2: $player2'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close',style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
       Scaffold(
      appBar: AppBar(
           backgroundColor: Colors.blue,
        title: Center(child: Text('Badminton Event',style:GoogleFonts.exo2(
          textStyle: TextStyle(color: Colors.white),
        ) )),
      ),
      body:Container(
        
        height: 1000,
        width: double.infinity,
       // duration: Duration(seconds: 5),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'
            //  _firstImage ? 'assets/background.jpg' : 'assets/background2.webp',
            ),
           fit: BoxFit.cover,
          ),
        ),
        
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${widget.teamAName} vs ${widget.teamBName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(widget.teamAName, style: TextStyle(fontSize: 20)),
                        Text('$teamAScore', style: TextStyle(fontSize: 36)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _incrementScoreA,
                              color: Colors.green,
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: _decrementScoreA,
                              color: Colors.red,
                            ),
                          ],
                        ),
                         Text(widget.teamAPlayer1),
                        if (widget.teamAPlayer2 != null)
                         Text(widget.teamAPlayer2!),
                       
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(widget.teamBName, style: TextStyle(fontSize: 20)),
                        Text('$teamBScore', style: TextStyle(fontSize: 36)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _incrementScoreB,
                              color: Colors.green,
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: _decrementScoreB,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        Text(widget.teamBPlayer1),
                        
                        //if(widget.teamBPlayer2??null)
                       // Text(?widget.teamBPlayer2.),
                        if (widget.teamBPlayer2 != null) 
                        Text(widget.teamBPlayer2!),
                      
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _matchComplete,
              child: Text('Match Complete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _resetScores,
              child: Text('Reset Scores'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
            SizedBox(height: 20),
            if (resultMessage.isNotEmpty)
              Column(
                children: [
                  if (showAnimation)
                    Lottie.asset('assets/celebration.json', width: 150, height: 150),
                  Text(
                    resultMessage,
                    style: GoogleFonts.exo2(
                      textStyle:TextStyle (fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green,),
                   
                    )
                    
                  
                  ),
                ],
              ),
          ],
        ),
      ),
      ),
       
    ));
 
  }
}
