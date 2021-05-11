import 'package:flutter/material.dart';
import 'package:gymkhana_app/Widgets/all_widgets.dart';
import 'package:gymkhana_app/firebase_services/firebase_repository.dart';
import 'package:gymkhana_app/views/HomePage/Home_widgets/post_tile.dart';

class ClubArchive extends StatefulWidget {
  final String _clubName;
  final FirestoreRepository _firestoreRepository;

  ClubArchive(this._clubName, this._firestoreRepository);

  @override
  _ClubArchiveState createState() => _ClubArchiveState();
}

class _ClubArchiveState extends State<ClubArchive> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: widget._firestoreRepository.getClubPosts(widget._clubName),
          initialData: <List<PostItem>>[],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  height: 200,
                  child: Row(
                    children: [
                      CustomNetworkImage(
                          clubProfiles[widget._clubName.toLowerCase()], 80),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              widget._clubName.toUpperCase(),
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${snapshot.data.length}',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Text(
                                  'POSTS',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                snapshot.data.length == 0
                    ? NothingToSee()
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return PostTile(postItem: snapshot.data[index]);
                        })
              ],
            );
          },
        ),
      ),
    );
  }
}

const clubProfiles = {
  'literature club iit jodhpur':
      """https://assets-2.placeit.net/smart_templates/13dd0f8bc046af45656d4a7c083f5173/assets/preview_c4d5a3708ff03cff7b56cafcabe9aff3.jpg""",
  'book club':
      """https://static.seattletimes.com/wp-content/uploads/2019/10/TZR-BookClub-780x501.jpg""",
  'the video editing & film making club iitj':
      """https://students.iitj.ac.in/media/club_2017/framex.jpg""",
  'cultural and literary society':
      """https://k6u8v6y8.stackpathcdn.com/blog/wp-content/uploads/2014/12/Cultural-Festivals-of-India.jpg""",
  'news letter iit jodhpur':
      """https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSlveb-F01M4Vb1y8M5czWmczjP1AzzsC1576f6YIJPDJFc78fvhMvpUFtIeseEgQLpRM&usqp=CAU""",
  'aero-modelling club':
      """https://www.iitg.ac.in/stud/gymkhana/technical/assets/img/resources/AeromodellingLogo.png""",
  'astronomy club':
      """https://students.iitj.ac.in/media/club_2017/dsst-astronomy-course_129108_large.jpg""",
  'automobile club':
      """https://thumbs.dreamstime.com/z/classic-car-emblem-automobile-club-logo-vector-143256595.jpg""",
  'electronics club':
      """https://media-exp1.licdn.com/dms/image/C4E1BAQE_NCmwYCscpQ/company-background_10000/0/1603466583355?e=2159024400&v=beta&t=bGHXyAH01a05E0hCs9kH9pQaQB48UKl6TJ5pDEbtYE4""",
  'programming club':
      """https://content.techgig.com/thumb/msid-79844104,width-860,resizemode-4/5-Best-programming-languages-to-learn-in-2021.jpg?140622""",
  'robotics club':
      """https://www.sciencenewsforstudents.org/wp-content/uploads/2019/11/860_main_robot_ethics.png""",
  'science club':
      """https://www.sciencenews.org/wp-content/uploads/2019/12/120719_scientistsrights_feat_opt2-1027x579.png""",
  'campus life society':
      """https://i.pinimg.com/originals/b5/c3/6a/b5c36a4272bc5fc7493ff59983eb0b81.jpg""",
  'entrepreneurship cell':
      """https://image.freepik.com/free-vector/young-online-entrepreneur-vector-illustration_80802-56.jpg""",
  'student academics & career society':
      """https://d3srkhfokg8sj0.cloudfront.net/wp-content/uploads/sites/669/0620_STD_AskProf_Feature2-696x313.jpg""",
  'sports society':
      """https://media.istockphoto.com/vectors/sports-set-of-athletes-of-various-sports-disciplines-isolated-vector-vector-id1141191007?b=1&k=6&m=1141191007&s=612x612&w=0&h=akacAAnMP7T7F2zVvApXW-qvkCMmO3IkPo83MMSrrXA=""",
  'the animation club iitj': """https://i.stack.imgur.com/DuPoE.gif""",
  'fine arts club iitj':
      """https://students.iitj.ac.in/media/club_2019/Fine_Arts_Club_Cover.jpg""",
  'the designing club iitj':
      """https://students.iitj.ac.in/media/club_2017/D3.jpg""",
  'the photography and photo-editing club iitj':
      """https://students.iitj.ac.in/media/club_2017/D3.jpg"""
};
