import 'package:flutter/material.dart';
import 'package:stacked_animated_list/ui/stacked_list_widget.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

const images = [
  'lib/Images/cod.jpeg',
  'lib/Images/fh5.jpeg',
  'lib/Images/fortnite.jpeg',
  'lib/Images/got.jpeg',
  'lib/Images/mc.jpeg',
  'lib/Images/rdr2.jpeg',
  'lib/Images/tlou2.jpeg',
];

class _SliderPageState extends State<SliderPage> {
  List<String> imageList = List.from(images);

  @override
  Widget build(BuildContext context) {
    const cardWidth = 300.0;

    final listItems = imageList.map((image) {
      return SizedBox(
        width: 250,
        child: AspectRatio(
          aspectRatio: .66,
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:
          StackedListWidget(
            listItems: listItems,
            rotationAngle: 5,
            listItemWidth: cardWidth,
            longPressDelay: 0,
          ),
      ),
    );
  }
}