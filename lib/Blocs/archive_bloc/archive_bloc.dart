import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pedantic/pedantic.dart';

class ArchiveState {}

abstract class ArchiveEvent extends Equatable {
  @override
  List<Object> get props => [];
}
