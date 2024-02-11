import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'constants.dart';
import 'game_screen.dart';
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
                Icon(Icons.menu, size: 40),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: ListView(children: [
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
            dropdownContents1: Text(
              'test1',
              style: TextStyle(color: Colors.white),
            ),
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
        const Center(
          child: Text(
            "Lights!",
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: 'Courier'),
            textAlign: TextAlign.center,
          ),
        ),
        const Center(
          child: Text(
            "Camera!",
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: 'Courier'),
            textAlign: TextAlign.center,
          ),
        ),
        const Center(
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

class Section extends StatelessWidget {
  final Widget child;
  final String title;
  const Section({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: foregroundColor),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontFamily: 'CenturyGothic', fontWeight: FontWeight.w700, fontSize: 20),
          ),
          child,
        ]),
      ),
    );
  }
}

class RoundLabelledImage extends StatelessWidget {
  final String title;
  final String imagePath;
  const RoundLabelledImage({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontFamily: 'CenturyGothic', fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }
}

class SingleDropdown extends StatefulWidget {
  final RoundLabelledImage roundImage;
  final Widget dropdownContents;

  const SingleDropdown({super.key, required this.roundImage, required this.dropdownContents});

  @override
  State<SingleDropdown> createState() => _SingleDropdownState();
}

class _SingleDropdownState extends State<SingleDropdown> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.roundImage,
                ),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ],
        ),
        if (isExpanded)
          Container(
            // width: 100,
            // height: 100,
            color: Colors.black,
            child: widget.dropdownContents,
          ),
      ],
    );
  }
}

class TwinDropdown extends StatefulWidget {
  final RoundLabelledImage roundImage1;
  final RoundLabelledImage roundImage2;

  final Widget dropdownContents1;
  final Widget dropdownContents2;

  const TwinDropdown({super.key, required this.roundImage1, required this.roundImage2, required this.dropdownContents1, required this.dropdownContents2});

  @override
  State<TwinDropdown> createState() => _TwinDropdownState();
}

class _TwinDropdownState extends State<TwinDropdown> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.roundImage1,
                ),
                onTap: () {
                  setState(() {
                    isExpanded2 = false;
                    isExpanded1 = !isExpanded1;
                  });
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
                  child: widget.roundImage2,
                ),
                onTap: () {
                  setState(() {
                    isExpanded1 = false;
                    isExpanded2 = !isExpanded2;
                  });
                },
              ),
            ),
          ],
        ),
        if (isExpanded1 || isExpanded2)
          Container(
            // width: 200,
            // height: 100,
            color: Colors.black,
            child: isExpanded1 ? widget.dropdownContents1 : widget.dropdownContents2,
          ),
      ],
    );
  }
}
