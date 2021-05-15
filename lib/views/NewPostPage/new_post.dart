import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymkhana_app/firebase_services/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/Blocs/new_post_bloc/new_post_bloc.dart';
import 'package:gymkhana_app/Widgets/all_widgets.dart';
import 'package:gymkhana_app/views/HomePage/Home_widgets/home_widgets.dart';

import '../../constants.dart';

class NewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
        child: BlocProvider(
            create: (context) => NewPostBloc(),
            child: BlocBuilder<NewPostBloc, NewPostState>(
                builder: (context, state) {
              final customUser =
                  context.read<AuthenticationRepository>().currentCustomUser;
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: theme.scaffoldBackgroundColor,
                    elevation: 0,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        style: ButtonStyle(alignment: Alignment.center),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: theme.textTheme.headline6,
                        ),
                      ),
                    ),
                    leadingWidth: 100,
                    automaticallyImplyLeading: false,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage(
                              imageUrl: '${customUser.photoUrl}',
                              height: 30,
                              width: 30,
                            )),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              9),
                                  backgroundColor:
                                      theme.scaffoldBackgroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: SingleChildScrollView(
                                      child: PostTile(
                                        postItem: PostItem(
                                            id: 'temp',
                                            authorID: 'no user',
                                            title: state.title,
                                            clubName: customUser.name,
                                            description: state.body,
                                            enableFeedback: state.feedback,
                                            photoUrl: customUser.photoUrl,
                                            comments: null),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        onLongPressEnd: (_) => Navigator.pop(context),
                        child: Center(
                          child: Text(
                            'Preview',
                            style: theme.textTheme.headline6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  body: InputForm());
            })));
  }
}

class InputForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<NewPostBloc, NewPostState>(
      builder: (context, state) {
        final customUser =
            context.read<AuthenticationRepository>().currentCustomUser;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text('Title ', style: theme.textTheme.headline5),
                    const SizedBox(width: 10),
                    Flexible(
                      child: TextFormField(
                        style: theme.textTheme.subtitle1,
                        maxLines: null,
                        onChanged: (val) {
                          context.read<NewPostBloc>().add(TitleChanged(val));
                        },
                        decoration: InputDecoration(
                            errorBorder: InputBorder.none,
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    onChanged: (val) {
                      context.read<NewPostBloc>().add(BodyChanged(val));
                    },
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Body',
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FeedbackConfirmation(),
              Container(
                alignment: Alignment.center,
                child: MaterialButton(
                  disabledColor: Colors.black38,
                  color: Colors.blueAccent,
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (state.formValid) {
                      final data = {
                        'photoUrl': customUser.photoUrl,
                        'title': state.title,
                        'description': state.body,
                        'create_timeStamp': Timestamp.now(),
                        'author_id': customUser.id,
                        'society': _clubToSociety[customUser.name.toLowerCase()]
                            .toLowerCase(),
                        'enableFeedback': state.feedback,
                        'club_name': customUser.name.toLowerCase(),
                        'last_updated': Timestamp.now()
                      };
                      await context
                          .read<NewPostBloc>()
                          .databaseServices
                          .updatePostData(postData: data);
                      Navigator.pop(context);

                      print('post added');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Title & body can't be empty")));
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }
}

final _clubToSociety = {
  'entrepreneurship cell': 'Academics and Career',
  'student academics & career society': 'Academics and Career',
  'the animation club iitj': 'Design and Arts',
  'fine arts club iitj': 'Design and Arts',
  'the designing club iitj': 'Design and Arts',
  'the video editing & film making club iitj': 'Design and Arts',
  'the photography and photo-editing club iitj': 'Design and Arts',
  'literature club iit jodhpur': 'Cult and Lit',
  'cultural and literary society': 'Cult and Lit',
  'news letter iit jodhpur': 'Cult and Lit',
  'book club': 'Cult and Lit',
  'aero-medelling club': 'Science and Tech',
  'astronomy club': 'Science and Tech',
  'automobile club': 'Science and Tech',
  'electronics club': 'Science and Tech',
  'programming club': 'Science and Tech',
  'robotics club': 'Science and Tech',
  'science club': 'Science and Tech',
  'sports society': 'Sports and Games',
  'bharat biradar (b19cse022)': 'Academics and Career',
  'bhagirathsinh sarvaiya (b19cse021)': 'Campus Life',
  'campus life society': 'Campus Life',
};

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2,
      thickness: 1,
      indent: 0,
      endIndent: 0,
      color: currentTheme == 'light' ? Colors.black : Colors.white60,
    );
  }
}
