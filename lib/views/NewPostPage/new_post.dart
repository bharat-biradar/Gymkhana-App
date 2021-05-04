import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymkhana_app/firebase_services/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/Blocs/new_post_bloc/new_post_bloc.dart';
import 'package:gymkhana_app/Widgets/all_widgets.dart';

class NewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.accentColor,
            title: Text(
              'New Post',
              style: theme.textTheme.headline5,
            ),
          ),
          body: BlocProvider(
            create: (context) => NewPostBloc(),
            child: InputForm(),
          )),
    );
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
              TextFormField(
                style: theme.textTheme.subtitle1,
                onChanged: (val) {
                  context.read<NewPostBloc>().add(TitleChanged(val));
                },
                decoration: InputDecoration(
                    errorText: state.titleValid ? null : 'Title > 15 chars',
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(width: 2),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: TextFormField(
                    onChanged: (val) {
                      context.read<NewPostBloc>().add(BodyChanged(val));
                    },
                    maxLines: null,
                    decoration: InputDecoration(
                        errorText: state.bodyValid ? null : 'Body > 45 chars',
                        hintText: 'Body',
                        focusedBorder: InputBorder.none,
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
                  onPressed: state.formValid
                      ? () async {
                          Map<String, dynamic> data = {
                            'photoUrl': customUser.photoUrl,
                            'title': state.title,
                            'description': state.body,
                            'create_timeStamp': Timestamp.now(),
                            'author_id': customUser.id,
                            'society':
                                _clubToSociety[customUser.name.toLowerCase()]
                                    .toLowerCase(),
                            'enableFeedback': state.feedback,
                            'club_name': customUser.name.toLowerCase()
                          };
                          await context
                              .read<NewPostBloc>()
                              .databaseServices
                              .updatePostData(postData: data);
                          Navigator.pop(context);

                          print('post added');
                        }
                      : null,
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
  'campus life society': 'Campus Life',
};
