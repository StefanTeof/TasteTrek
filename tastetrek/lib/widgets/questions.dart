// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     home: QuestionnaireScreen(),
//   ));
// }

// class QuestionnaireScreen extends StatefulWidget {
//   @override
//   _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
// }

// class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
//   Map<String, String> selectedChoices = {};
//   int currentPageIndex = 0;
//   PageController pageController = PageController();

//   final List<QuestionModel> questions = [
//     QuestionModel(
//       question: 'Food or Drink?',
//       choices: ['Food', 'Drink'],
//     ),
//     QuestionModel(
//       question: 'Another Question?',
//       choices: ['Choice A', 'Choice B', 'Choice C'],
//     ),
//   ];

//   void selectChoice(String question, String choice) {
//     setState(() {
//       selectedChoices[question] = choice;
//     });
//   }

//   void submitAnswers() {
//     if (currentPageIndex < questions.length - 1) {
//       pageController.nextPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       print(selectedChoices);
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => RecipeWidget()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Questionnaire'),
//       ),
//       body: PageView.builder(
//         controller: pageController,
//         itemCount: questions.length,
//         onPageChanged: (index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         itemBuilder: (context, index) {
//           return QuestionWidget(
//             question: questions[index].question,
//             choices: questions[index].choices,
//             onSelect: (choice) => selectChoice(questions[index].question, choice),
//             onNext: () => ,
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: submitAnswers,
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }





// // class QuestionWidget extends StatelessWidget {
// //   final String question;
// //   final List<String> choices;
// //   final Function(String) onSelect;

// //   QuestionWidget({
// //     required this.question,
// //     required this.choices,
// //     required this.onSelect,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.5),
// //             spreadRadius: 2,
// //             blurRadius: 5,
// //             offset: Offset(0, 3),
// //           ),
// //         ],
// //       ),
// //       margin: EdgeInsets.all(20),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: <Widget>[
// //           Text(
// //             question,
// //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //           ),
// //           SizedBox(height: 20),
// //           Column(
// //             children: choices.map((choice) {
// //               return GestureDetector(
// //                 onTap: () => onSelect(choice),
// //                 child: Container(
// //                   padding: EdgeInsets.symmetric(vertical: 12),
// //                   alignment: Alignment.center,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(10),
// //                     color: Colors.grey[200],
// //                   ),
// //                   child: Text(choice),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// class QuestionWidget extends StatelessWidget {
//   final String question;
//   final VoidCallback onNext;
//   final Function(String) onAnswered;
//   final List<String> choices;
//   final Function(String) onSelect;

//   const QuestionWidget({
//     Key? key,
//     required this.question,
//     required this.onNext,
//     required this.onAnswered,
//     required this.choices,
//     required this.onSelect,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(247, 247, 247, 1),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 question,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Montserrat',
//                   fontSize: 24,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 question,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Montserrat',
//                   fontSize: 16,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Column(
//               children: choices.map((choice) {
//                 return ElevatedButton(
//                   onPressed: () => onSelect(choice),
//                   child: Text(choice),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromRGBO(254, 189, 46, 1),
//                     textStyle: TextStyle(
//                       fontFamily: 'Montserrat Alternates',
//                       fontSize: 16,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: onNext,
//               child: Text('Next'),
//               style: ElevatedButton.styleFrom(
//                 primary: Color.fromRGBO(254, 189, 46, 1),
//                 textStyle: TextStyle(
//                   fontFamily: 'Montserrat',
//                   fontSize: 20,
//                 ),
//                 minimumSize: Size(120, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class RecipeWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recipes'),
//       ),
//       body: Center(
//         child: Text('Recipe Widget'),
//       ),
//     );
//   }
// }

// class QuestionModel {
//   final String question;
//   final List<String> choices;

//   QuestionModel({required this.question, required this.choices});
// }


// class QuestionWidget extends StatelessWidget {
//   final String question;
//   final VoidCallback onNext;
//   final Function(String) onAnswered;
//   final List<String> choices;
//   final Function(String) onSelect;

//   const QuestionWidget({
//     Key? key,
//     required this.question,
//     required this.onNext,
//     required this.onAnswered,
//     required this.choices,
//     required this.onSelect,

//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(247, 247, 247, 1),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Food or drink?',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Montserrat',
//                   fontSize: 24,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 question,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Montserrat',
//                   fontSize: 16,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => onAnswered(choice),
//                   child: Text(choice),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromRGBO(254, 189, 46, 1),
//                     textStyle: TextStyle(
//                       fontFamily: 'Montserrat Alternates',
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => onAnswered('Drink'),
//                   child: Text('Drink'),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromRGBO(254, 189, 46, 1),
//                     textStyle: TextStyle(
//                       fontFamily: 'Montserrat Alternates',
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: onNext,
//               child: Text('Next'),
//               style: ElevatedButton.styleFrom(
//                 primary: Color.fromRGBO(254, 189, 46, 1),
//                 textStyle: TextStyle(
//                   fontFamily: 'Montserrat',
//                   fontSize: 20,
//                 ),
//                 minimumSize: Size(120, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: QuestionnaireScreen(),
  ));
}

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  Map<String, String> selectedChoices = {};
  int currentPageIndex = 0;
  PageController pageController = PageController();

  final List<QuestionModel> questions = [
    QuestionModel(
      question: 'Food or Drink?',
      choices: ['Food', 'Drink'],
    ),
    QuestionModel(
      question: 'Another Question?',
      choices: ['Choice A', 'Choice B', 'Choice C'],
    ),
  ];

  void selectChoice(String question, String choice) {
    setState(() {
      selectedChoices[question] = choice;
    });
  }

  void submitAnswers() {
    if (currentPageIndex < questions.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      print(selectedChoices);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecipeWidget()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromRGBO(254, 189, 46, 1),
            width: double.infinity,
            height: 100, // Adjust height as needed
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: questions.length,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return QuestionWidget(
                  question: questions[index].question,
                  choices: questions[index].choices,
                  onSelect: (choice) => selectChoice(questions[index].question, choice),
                  onNext: submitAnswers,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final String question;
  final List<String> choices;
  final Function(String) onSelect;
  final VoidCallback onNext;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.choices,
    required this.onSelect,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color.fromRGBO(247, 247, 247, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40), // Added to move the question higher
          Text(
            question,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: choices.map((choice) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () => onSelect(choice),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60, // Increased width of choice container
                        height: 60, // Increased height of choice container
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(254, 189, 46, 1),
                        ),
                        child: Center(
                          child: Text(
                            choice,
                            style: TextStyle(
                              color: Colors.black, // Changed to black color
                              fontFamily: 'Montserrat',
                              fontSize: 18, // Increased font size
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20), // Increased space between choice and text
                      Text(
                        choice,
                        style: TextStyle(
                          color: Colors.black, // Changed to black color
                          fontFamily: 'Montserrat',
                          fontSize: 18, // Increased font size
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNext,
            child: Text('Next'),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(254, 189, 46, 1),
              textStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
              ),
              minimumSize: Size(120, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          SizedBox(height: 20), // Added to space out the button from the choices
        ],
      ),
    );
  }
}

class RecipeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: Center(
        child: Text('Recipe Widget'),
      ),
    );
  }
}

class QuestionModel {
  final String question;
  final List<String> choices;

  QuestionModel({required this.question, required this.choices});
}


