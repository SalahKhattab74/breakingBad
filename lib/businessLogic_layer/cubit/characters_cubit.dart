import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test1/data_layer/models/characters.dart';
import 'package:test1/data_layer/models/quotes.dart';
import 'package:test1/data_layer/repositery/characters_respositery.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) => {
          emit(CharactersLoaded(characters)),
          this.characters = characters,
        });
    return characters;
  }

  void getQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) => {
          emit(QuotesLoaded(quotes)),
        });
  }
}
