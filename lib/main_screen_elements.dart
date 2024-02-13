import 'package:colorguesser/constants.dart';
import 'package:flutter/material.dart';

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
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontFamily: 'CenturyGothic', fontWeight: FontWeight.w700, fontSize: 20),
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
          style: const TextStyle(color: Colors.white, fontFamily: 'CenturyGothic', fontWeight: FontWeight.w700, fontSize: 20),
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
