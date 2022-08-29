part of 'image_bloc.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageFetched extends ImageState {
  final File image;
  ImageFetched({ required this.image });
}

class ImageCanceled extends ImageState {

}