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
                  padding: EdgeInsets.all(25),
                  height: 150,
                  child: Row(
                    children: [
                      CustomNetworkImage(
                          clubProfiles[widget._clubName.toLowerCase()], 80),
                      const SizedBox(width: 40),
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
  'The video editing & film making club iitj':
      """https://students.iitj.ac.in/media/club_2017/framex.jpg""",
  'cultural and literary society':
      """https://k6u8v6y8.stackpathcdn.com/blog/wp-content/uploads/2014/12/Cultural-Festivals-of-India.jpg""",
  'news letter iit jodhpur':
      """https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSlveb-F01M4Vb1y8M5czWmczjP1AzzsC1576f6YIJPDJFc78fvhMvpUFtIeseEgQLpRM&usqp=CAU""",
  'aero-modelling club':
      """http://www.iitg.ac.in/stud/gymkhana/technical/assets/img/resources/AeromodellingLogo.png""",
};
