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
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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

class ScreenLightMenu extends StatefulWidget {
  const ScreenLightMenu({Key? key}) : super(key: key);

  @override
  State<ScreenLightMenu> createState() => _ScreenLightMenuState();
}

class _ScreenLightMenuState extends State<ScreenLightMenu> {
  List<Color> colors = []; // Dynamic list to track added colors
  String selectedEffect = 'None';
  final Map<String, String> effectDescriptions = {
    'None': 'Color will not change. Note that only the first color will be displayed!',
    'Cycle': 'Color will smoothly fade from one to the next.',
    'Instant': 'Color will instantaneously change from one to the next.',
    'Gradient': 'Color will transition from one to the next through a gradient.',
    'Strobe': 'Color will turn black before instantaneously changing to the next.',
  };
  double _currentTimingInSeconds = 1.0; // Default starting timing in seconds
  double _maxSliderValue = 1000000; // Max slider value in microseconds
  final TextEditingController _timingController = TextEditingController(text: "1.0");

  double red = 0, green = 0, blue = 0; // Initial RGB values
  void _addNewColor() async {
    // Reset RGB sliders
    double localRed = 0, localGreen = 0, localBlue = 0;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Color'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      color: Color.fromRGBO(localRed.toInt(), localGreen.toInt(), localBlue.toInt(), 1),
                    ),
                    Slider(
                      value: localRed,
                      min: 0,
                      max: 255,
                      onChanged: (value) {
                        setState(() {
                          localRed = value;
                        });
                      },
                    ),
                    Slider(
                      value: localGreen,
                      min: 0,
                      max: 255,
                      onChanged: (value) {
                        setState(() {
                          localGreen = value;
                        });
                      },
                    ),
                    Slider(
                      value: localBlue,
                      min: 0,
                      max: 255,
                      onChanged: (value) {
                        setState(() {
                          localBlue = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  colors.add(Color.fromRGBO(localRed.toInt(), localGreen.toInt(), localBlue.toInt(), 1));
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Colors',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: _addNewColor,
              icon: const Icon(Icons.add),
              label: const Text("Add new Color"),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor, // Updated to use theme color
              ),
            ),
          ),
          Wrap(
            children: colors
                .map((color) => Container(
                      width: 50,
                      height: 50,
                      color: color,
                      margin: const EdgeInsets.all(2),
                    ))
                .toList(),
          ),
          Text(
            'Choose Effect',
            style: TextStyle(color: Colors.white),
          ),
          DropdownButton<String>(
            dropdownColor: Colors.grey,
            value: selectedEffect,
            onChanged: (String? newValue) {
              setState(() {
                selectedEffect = newValue!;
              });
            },
            items: effectDescriptions.keys.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              effectDescriptions[selectedEffect] ?? '',
              style: TextStyle(color: Colors.white),
            ),
          ),

          //TIMING
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Choose timing in seconds',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Slider(
            min: 1,
            max: _maxSliderValue,
            divisions: 1000000, // Optional: Adjust based on desired granularity
            value: _currentTimingInSeconds * 1000000, // Convert seconds to microseconds for the slider
            onChanged: (value) {
              setState(() {
                _currentTimingInSeconds = value / 1000000; // Convert back to seconds
                _timingController.text = _currentTimingInSeconds.toStringAsFixed(2); // Update the text field
              });
            },
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _timingController,
                  decoration: InputDecoration(
                    labelText: 'Timing (seconds)',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Set border color to white
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Set border color to white when focused
                    ),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white), // Set input text color to white
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (value) {
                    double enteredValue = double.tryParse(value) ?? 1.0;
                    setState(() {
                      _currentTimingInSeconds = enteredValue;
                      double newMicroseconds = enteredValue * 1000000;
                      if (newMicroseconds > _maxSliderValue) {
                        _maxSliderValue = newMicroseconds;
                      } else if (_maxSliderValue > 1000000 && newMicroseconds <= 1000000) {
                        _maxSliderValue = 1000000;
                      }
                      _timingController.text = enteredValue.toStringAsFixed(2);
                    });
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Optional: Implement if you want an edit icon action
                },
              ),

              //START LIGHTS

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LightShowScreen(
                      colors: colors,
                      effect: selectedEffect,
                      timingInSeconds: _currentTimingInSeconds,
                    ),
                  ));
                },
                child: Text('ACTIVATE LIGHT'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ColorPreview extends StatelessWidget {
  final double red, green, blue;
  const ColorPreview({Key? key, required this.red, required this.green, required this.blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), 1),
    );
  }
}

class LightShowScreen extends StatefulWidget {
  final List<Color> colors;
  final String effect;
  final double timingInSeconds;

  const LightShowScreen({
    Key? key,
    required this.colors,
    required this.effect,
    required this.timingInSeconds,
  }) : super(key: key);

  @override
  State<LightShowScreen> createState() => _LightShowScreenState();
}

class _LightShowScreenState extends State<LightShowScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  int _currentColorIndex = 0;
  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController regardless of the effect
    _controller = AnimationController(
      duration: Duration(seconds: widget.timingInSeconds.toInt()),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    if (widget.colors.isNotEmpty) {
      // Setup color animation for both 'Cycle' and 'None' effects
      // For 'None', this setup will simply not cycle beyond the first color
      _setupColorAnimation();

      _controller.forward();

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _currentColorIndex++;
          if (_currentColorIndex >= widget.colors.length) {
            _currentColorIndex = 0; // Reset to first color
          }

          // For 'Instant', we need to manually trigger the change to ensure it's instant
          if (widget.effect == 'Instant') {
            setState(() {}); // Force widget to rebuild with the new color
          }

          _setupColorAnimation();
          _controller.forward(from: 0.0); // Restart the animation for both 'Cycle' and 'Instant'
        }
      });
    }
  }

  void _setupColorAnimation() {
    if (widget.effect == 'Cycle') {
      int nextColorIndex = _currentColorIndex + 1 < widget.colors.length ? _currentColorIndex + 1 : 0;
      _colorAnimation = ColorTween(
        begin: widget.colors[_currentColorIndex],
        end: widget.colors[nextColorIndex],
      ).animate(_controller);
    } else {
      // For both 'Instant' and 'None', set the color without tweening
      _colorAnimation = AlwaysStoppedAnimation<Color?>(widget.colors[_currentColorIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Container(
              color: _colorAnimation.value ?? widget.colors.first,
              child: Center(
                child: Text('Tap anywhere to go back', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
