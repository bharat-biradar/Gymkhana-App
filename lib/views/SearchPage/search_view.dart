import 'package:flutter/material.dart';
import 'package:gymkhana_app/constants.dart';
import 'package:gymkhana_app/views/HomePage/Home_widgets/post_tile.dart';
import '../../firebase_services/firebase_repository.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _controller = TextEditingController();

  var _postsResult = <PostItem>[];

  var _allPosts = <PostItem>[];

  void _searchPosts(String _searchTerm) {
    if (_searchTerm.length == 0) {
      setState(() {
        _postsResult.clear();
      });

      return;
    }
    var posts = <PostItem>[];
    _searchTerm = _searchTerm.toLowerCase();
    _allPosts.forEach((element) {
      if (element.title.toLowerCase().contains(_searchTerm) ||
          element.description.toLowerCase().contains(_searchTerm)) {
        posts.add(element);
      }
    });
    setState(() {
      _postsResult = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreRepository(uid: "any").getAllPosts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _allPosts = snapshot.data;
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  elevation: 10,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _controller.text = '';
                            _postsResult.clear();
                          });
                        })
                  ],
                  title: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: currentTheme == 'light'
                          ? const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500)
                          : null,
                    ),
                    onChanged: _searchPosts,
                  ),
                ),
                body: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    itemCount: _postsResult.length,
                    itemBuilder: (context, index) {
                      return PostTile(postItem: _postsResult[index]);
                    })),
          );
        });
  }
}
