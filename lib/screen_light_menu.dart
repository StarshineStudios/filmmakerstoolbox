import 'package:colorguesser/light_show_screen.dart';
import 'package:colorguesser/main.dart';
import 'package:flutter/material.dart';

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
    'Gradient': 'Color will transition from one to the next through a gradient. TWO OR MORE COLORS REQUIRED.',
    'Strobe': 'Color will turn black before instantaneously changing to the next.',
  };
  double _currentTimingInSeconds = 1.0; // Default starting timing in seconds
  double _maxSliderValue = 1000000; // Max slider value in microseconds
  final TextEditingController _timingController = TextEditingController(text: "1.0");
  bool isPure = false;

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
    bool activateIsActive = (selectedEffect == 'Gradient' && colors.length >= 2) || (selectedEffect != 'Gradient' && colors.isNotEmpty);

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
                      color: isPure ? pureHue(color) : color,
                      margin: const EdgeInsets.all(2),
                    ))
                .toList(),
          ),
          const Text(
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
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              effectDescriptions[selectedEffect] ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),

          //TIMING
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
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
                  decoration: const InputDecoration(
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
                  style: const TextStyle(color: Colors.white), // Set input text color to white
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Optional: Implement if you want an edit icon action
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Is Pure Hue (Reccomended): ${isPure ? "True" : "False"}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Switch(
                inactiveTrackColor: Colors.grey,
                value: isPure,
                onChanged: (value) {
                  setState(() {
                    isPure = value; // Toggle the state of isPure
                  });
                },
              ),
            ],
          ),
          //START LIGHTS

          ElevatedButton(
            onPressed: activateIsActive
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LightShowScreen(
                        colors: colors,
                        effect: selectedEffect,
                        timingInSeconds: _currentTimingInSeconds,
                        pureHue: isPure,
                      ),
                    ));
                  }
                : null,
            child: const Text(
              'ACTIVATE LIGHT',
            ),
          ),
        ],
      ),
    );
  }
}
