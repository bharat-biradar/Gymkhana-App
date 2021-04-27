import 'package:flutter/material.dart';
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
            if (snapshot.data.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("There's",
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset("assets/images/nothing.gif"),
                    const SizedBox(height: 10),
                    Text("to see", style: Theme.of(context).textTheme.headline4)
                  ],
                ),
              );
            } else {
              print(snapshot.data);
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PostTile(postItem: snapshot.data[index]);
                  });
            }
          },
        ),
      ),
    );
  }
}
