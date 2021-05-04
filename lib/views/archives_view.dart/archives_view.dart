import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gymkhana_app/Widgets/all_widgets.dart';
import 'package:gymkhana_app/constants.dart';
import 'package:gymkhana_app/firebase_services/firebase_repository.dart';
import 'package:gymkhana_app/views/HomePage/Home_widgets/clubs_slider.dart';
import 'package:gymkhana_app/views/archives_view.dart/archive_club_list.dart';

class ArchivePage extends StatefulWidget {
  final FirestoreRepository _firestoreRepository;

  ArchivePage(this._firestoreRepository);

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  int _selected = 0;
  static const SocietiesList = <List<String>>[
    [
      'assets/images/design.jpg',
      'Design and Arts',
    ],
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
  ];

  static const _clubsList = <List<String>>[
    [
      'The Animation club iitj',
      'Fine Arts club iitj',
      'The Designing club iitj',
      'The Video editing & Film making club iitj',
      'The Photography and Photo-editing club iitj'
    ],
    [
      'Literature Club IIT Jodhpur',
      'Book club',
      'Cultural and Literary society',
      'News Letter IIT Jodhpur'
    ],
    [
      'Aero-modelling club',
      'Astronomy Club',
      'Automobile club',
      'Electronics club',
      'Programming club',
      'Robotics club',
      'Science club'
    ],
    ['Campus Life Society'],
    ['Entrepreneurship cell', 'Student Academics & Career society'],
    ['Sports Society'],
  ];

  var _currentClubsList = <String>[];
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
                  itemCount: SocietiesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selected = index + 1;
                          _currentClubsList = _clubsList[index];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.all(8),
                        decoration: _selected == index + 1
                            ? innerShadow(20)
                            : neumorphicBorderDecoration(context,
                                borderRadius: 20,
                                offset1: currentTheme == 'light' ? 6 : 2,
                                offset2: 2,
                                spreadRadius: 0,
                                blurRadius: 10),
                        child: ClubIcon(
                          imageLoc: SocietiesList[index][0],
                          title: SocietiesList[index][1],
                          myNor: index + 1,
                        ),
                      ),
                    );
                  })),
          SizedBox(height: 20),
          ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: _currentClubsList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: neumorphicBorderDecoration(context,
                      borderRadius: 15,
                      offset1: currentTheme == 'light' ? 5 : 1,
                      offset2: 3,
                      spreadRadius: 1,
                      blurRadius: 7),
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClubArchive(
                                _currentClubsList[index],
                                widget._firestoreRepository))),
                    title: Text(
                      _currentClubsList[index],
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
