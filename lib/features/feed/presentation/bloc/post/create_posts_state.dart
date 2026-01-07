import 'package:equatable/equatable.dart';

abstract class CreatePostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreatePostInitial extends CreatePostsState {}

class CreatePostLoading extends CreatePostsState {}

class CreatePostSuccess extends CreatePostsState {}

class CreatePostFailure extends CreatePostsState {
  final String messsage;
  CreatePostFailure({required this.messsage});
}
