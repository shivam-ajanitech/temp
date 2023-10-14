import 'package:flutter/material.dart';

class TestScrn extends StatefulWidget {
  const TestScrn({Key? key}) : super(key: key);

  @override
  State<TestScrn> createState() => _TestScrnState();
}

class _TestScrnState extends State<TestScrn> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MavCard(name: 'shivam'),
          MavCard(name: 'shsdsam')
        ],
      ),
    );
  }
}

class MavCard extends StatelessWidget {
  final String name;
  const MavCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(name),
    );
  }
}
