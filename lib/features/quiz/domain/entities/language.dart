import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Language extends Equatable {
  final String name;
  final String code;
  
  Language({
    @required this.name,
    @required this.code,
  });

  @override
  List<Object> get props => [name, code];
}
