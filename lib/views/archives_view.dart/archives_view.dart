import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gymkhana_app/Widgets/all_widgets.dart';
import 'package:gymkhana_app/views/HomePage/Home_widgets/clubs_slider.dart';

class ArchivePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ArchivePage());
  }

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  int _selected = 0;
  static const ClubsList = <List<String>>[
    [
      'assets/images/cult.jpg',
      'Cult and Lit',
    ],
    ['assets/images/sctch.jpg', 'Science and Tech'],
    [
      'assets/images/camplife.jpg',
      'Campus Life',
    ],
    [
      'assets/images/acads.jpg',
      'Academics and Career',
    ],
    [
      'assets/images/sports.jpg',
      'Sports and Games',
    ],
    [
      'assets/images/design.jpg',
      'Design and Arts',
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          Container(
              height: 130,
              child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ClubsList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selected = index + 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.all(8),
                        decoration: _selected == index + 1
                            ? innerShadow(20)
                            : neumorphicBorderDecoration(context,
                                borderRadius: 20,
                                offset1: 10,
                                offset2: 2,
                                spreadRadius: 0,
                                blurRadius: 10),
                        child: ClubIcon(
                          imageLoc: ClubsList[index][0],
                          title: ClubsList[index][1],
                          myNor: index + 1,
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
