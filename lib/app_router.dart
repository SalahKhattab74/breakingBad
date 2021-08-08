import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/businessLogic_layer/cubit/characters_cubit.dart';
import 'package:test1/constants/strings.dart';
import 'package:test1/data_layer/models/characters.dart';
import 'package:test1/data_layer/repositery/characters_respositery.dart';
import 'package:test1/data_layer/web_services/characters_web_services.dart';
import 'package:test1/presentation_layer/screens/characters_details_screen.dart';
import 'package:test1/presentation_layer/screens/characters_screen.dart';

class AppRouter {
  CharactersRepository charactersRepository;
  CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case charactersDetailsScreen:
        final character = settings.arguments as Character; //casting
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    CharactersCubit(charactersRepository),
                child: CharacterDetailsScreen(character: character)));
    }
  }
}
