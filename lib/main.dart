import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_bay/state/bloc/community_bloc.dart';
import 'package:social_bay/state/bloc/follower_bloc.dart';

import 'app.dart';
import 'state/bloc/photos_bloc.dart';
import 'state/bloc/location_bloc.dart';
import 'state/bloc/user_bloc.dart';

void main(List<String> args) {
  return runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => PhotosBloc(),
      ),
      BlocProvider(
        create: (context) => LocationBloc(),
      ),
      BlocProvider(
        create: (context) => UserBloc(),
      ),
      BlocProvider(
        create: (context) => CommunityBloc(
          context.read<PhotosBloc>(),
          context.read<UserBloc>(),
        ),
      ),
      BlocProvider(
        create: (context) => FollowerBloc(
          context.read<PhotosBloc>(),
          context.read<UserBloc>(),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // fetch the photos
    BlocProvider.of<PhotosBloc>(context).add(FetchPhotos());
    BlocProvider.of<LocationBloc>(context).add(FetchUserLocation());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* Global App Configuration */
      theme: ThemeData.light(),
      home: const App(),
    );
  }
}
