import 'package:colorguesser/main_screen_elements.dart';
import 'package:colorguesser/screen_light_menu.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

// import 'package:google_nav_bar/google_nav_bar.dart';
import 'constants.dart';

const generalBox = 'generalBoxString';
void main() async {
  await Hive.initFlutter();
  await Hive.openBox(generalBox);
  runApp(const FilmmakersToolboxApp());
}

class FilmmakersToolboxApp extends StatelessWidget {
  const FilmmakersToolboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FilmmakersToolboxScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// List<Widget> pages = [
//   // const GameScreen(),
//   // const SettingsScreen(),
// ];

class FilmmakersToolboxScreen extends StatefulWidget {
  const FilmmakersToolboxScreen({super.key});

  @override
  State<FilmmakersToolboxScreen> createState() => _FilmmakersToolboxScreenState();
}

class _FilmmakersToolboxScreenState extends State<FilmmakersToolboxScreen> {
  int navBarIndex = 0;
  bool isMenuExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: SizedBox(
          height: 90,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FittedBox(
                //   fit: BoxFit.contain,
                //   child: Padding(
                //     padding: const EdgeInsets.all(100),
                //     child:
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Image.asset(
                    'assets/iconTransparentScaled.png',
                  ),
                ),
                const Icon(Icons.menu, size: 40),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: ListView(children: const [
        // const
        // Center(
        //   child: Text(
        //     "Filmmaker's toolbox",
        //     style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: 'Courier'),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        Section(
          title: 'LIGHTS',
          child: TwinDropdown(
            roundImage1: RoundLabelledImage(title: 'SCREEN', imagePath: 'assets/appIcon.png'),
            dropdownContents1: ScreenLightMenu(),
            roundImage2: RoundLabelledImage(title: 'FLASH', imagePath: 'assets/appIcon.png'),
            dropdownContents2: Text(
              'test2',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Section(
          title: 'CAMERA',
          child: SingleDropdown(
            roundImage: RoundLabelledImage(title: 'PRO CAMERA', imagePath: 'assets/appIcon.png'),
            dropdownContents: Text(
              'test1',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Center(
          child: Text(
            "Lights!",
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: 'Courier'),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Text(
            "Camera!",
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: 'Courier'),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Text(
            "Action!",
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: 'Courier'),
            textAlign: TextAlign.center,
          ),
        )
      ]),
    );
  }
}


// class ColorPreview extends StatelessWidget {
//   final double red, green, blue;
//   const ColorPreview({Key? key, required this.red, required this.green, required this.blue}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 100,
//       color: Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), 1),
//     );
//   }
// }
