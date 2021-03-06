import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:petgram_mobile_app/bloc/delete_post_bloc/delete_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/edit_post_bloc/edit_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/screens/profile_screen/ProfileScreen.dart';
import 'package:petgram_mobile_app/screens/profile_screen/profile_loading.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyProfileBloc>(context)..add(FetchMyProfile());
    BlocProvider.of<DeletePostBloc>(context);
    BlocProvider.of<EditPostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MyProfileBloc,MyProfileState>(
        listener: (context,state){
          if(state is MyProfileFailure){
            Scaffold.of(context)..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.msg),
                ));
          }
        },
        builder: (context,state){
          print(state);
          if(state is MyProfileLoading){
            return ProfileScreenLoading();
          }
          if(state is MyProfileFailure){
            return Center(
              child: Text(state.msg),
            );
          }
          if(state is MyProfileLoaded){

            return ProfileScreen(
              userDetail: state.userProfileModel.user,
            );
          }
          return Container();
        },
      ),
    );
  }
}

