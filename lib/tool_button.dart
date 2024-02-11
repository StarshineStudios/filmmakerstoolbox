// import 'package:colorguesser/constants.dart';
// // import 'package:colorguesser/core/constants.dart';
// // import 'package:colorguesser/files_latin/latin_getters.dart';
// // import 'package:colorguesser/screens/practice_screen.dart';
// // import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// class ToolButton extends StatelessWidget {
//   final String imagePath;
//   final String name;
//   final String description;
//   final int index; //The index in a list. I may need to make this more elegant later
//   final VoidCallback onPressed;
//   final VoidCallback onNounButtonPressed;
//   final VoidCallback onVerbButtonPressed;

//   final bool isExpanded;
//   const ToolButton({
//     super.key,
//     required this.imagePath,
//     required this.name,
//     required this.index,
//     required this.onPressed,
//     required this.description,
//     required this.isExpanded,
//     required this.onNounButtonPressed,
//     required this.onVerbButtonPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     //paddding around the long rectangle
//     return Padding(
//       padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
//       child: GestureDetector(
//         onTap: onPressed,

//         //The container itself, the long rectangle
//         child: Container(
//           decoration: BoxDecoration(
//             color: lightColor,
//             borderRadius: BorderRadius.circular(25.0),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             //the elements inside
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     //The Flag
//                     Container(
//                       height: 80,
//                       width: 80, // Adjust the size as needed
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         image: DecorationImage(
//                           image: AssetImage(imagePath),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     //The Text
//                     Expanded(
//                       child: FittedBox(
//                         alignment: Alignment.centerLeft,
//                         fit: BoxFit.scaleDown,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 name,
//                                 style: const TextStyle(fontSize: 30, color: backgroundColor, fontFamily: 'Coustard', fontWeight: FontWeight.bold),
//                               ),
//                               if (description != '')
//                                 Text(
//                                   description,
//                                   style: const TextStyle(fontSize: 25, color: backgroundColor, fontFamily: 'Coustard'),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 //The popup thing below
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   height: isExpanded ? 100.0 : 0.0,
//                   child: AnimatedOpacity(
//                     opacity: isExpanded ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 400),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           bottom: 60,
//                           left: 0,
//                           right: 0,
//                           child: Center(
//                             child: Text(
//                               'DESCRIPTION',
//                               style: const TextStyle(fontSize: 25, color: backgroundColor, fontFamily: 'Coustard'),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 0,
//                           right: 0,
//                           bottom: 0,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               NiceButton(
//                                 onPressed: onNounButtonPressed,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'textDecline',
//                                     style: const TextStyle(fontSize: 25, color: backgroundColor, fontFamily: 'Coustard'),
//                                   ),
//                                 ),
//                               ),
//                               NiceButton(
//                                 onPressed: onVerbButtonPressed,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'textConjugate',
//                                     style: const TextStyle(fontSize: 25, color: backgroundColor, fontFamily: 'Coustard'),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ToolButtonHolder extends StatefulWidget {
//   const ToolButtonHolder({super.key});
//   @override
//   State<ToolButtonHolder> createState() => _ToolButtonHolderState();
// }

// class _ToolButtonHolderState extends State<ToolButtonHolder> {
//   bool isExpanded = false;

//   int expandedIndex = -1; //nothing is expanded by default

//   void changeExpandedIndex(int newIndex) {
//     setState(() {
//       if (expandedIndex == newIndex) {
//         expandedIndex = -1;
//       } else {
//         expandedIndex = newIndex;
//       }
//     });
//   }

//   // void launchGame(Function() getFunction) {
//   //   Navigator.of(context).push(
//   //     MaterialPageRoute(
//   //       builder: (context) => PracticeScreen(
//   //         getFunction: getFunction,
//   //       ),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> boxElement = [
//       Padding(
//         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//         child: Container(
//           padding: const EdgeInsets.all(8.0),
//           decoration: const BoxDecoration(
//             color: lightColor,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(12),
//               bottomRight: Radius.circular(12),
//             ),
//           ),
//           child: const Center(
//             child: FittedBox(
//               fit: BoxFit.fitWidth,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
                  
//                   Text(
//                     "Filmmaker's Toolbox!",
//                     style: TextStyle(fontSize: 60, color: backgroundColor, fontFamily: 'Coustard', fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       ToolButton(
//         imagePath: 'assets/FlagRome.png',
//         name: 'textLatin',
//         description: '',
//         index: 0,
//         isExpanded: expandedIndex == 0,
//         onPressed: () {
//           changeExpandedIndex(0);
//         },
//         onNounButtonPressed: () {
          
//         },
//         onVerbButtonPressed: () {
//         },
//       ),
//       ToolButton(
//         imagePath: 'assets/FlagItaly.png',
//         name: 'textItalian',
//         description: 'comingSoonText',
//         index: 1,
//         isExpanded: expandedIndex == 1,
//         onPressed: () {
//           changeExpandedIndex(1);
//         },
//         onNounButtonPressed: () {},
//         onVerbButtonPressed: () {},
//       ),
//     ];

//     return Scaffold(backgroundColor: fadedColor, body: ListView(children: boxElement));
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     home: ToolButtonHolder(),
//   ));
// }
