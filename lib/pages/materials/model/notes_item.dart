import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotesItem extends Equatable{

  final String id;
  final String name;
  final String subTag1;
  final String subTag2;
  final String pages;
  final String size;
  final String icon;
  final bool isPrime;
  final String link;

  const NotesItem({
    required this.id,
    required this.name,
    required this.size,
    required this.icon,
    required this.link,
    required this.pages,
    required this.subTag1,
    required this.isPrime,
    required this.subTag2
  });

  static List<NotesItem> getNotesItemsList(List<dynamic> data){
    return data.map((e) => NotesItem.fromJson(e)).toList();
  }

  factory NotesItem.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final name = data['name'];
    final size = data['size'];
    final icon = data['icon'];
    final link = data['link'];
    final pages = data['pages'];
    final subTag1 = data['subTag1'];
    final subTag2 = data['subTag2'];
    final isPrime = data['isPrime'];

    return NotesItem(
      id: id,
      name: name,
      size: size,
      icon: icon,
      link: link,
      pages: pages,
      subTag1: subTag1,
      subTag2: subTag2, isPrime: isPrime
    );
  }

  static Map<String, dynamic> toMap(NotesItem item) => {
    "id": item.id,
    "name": item.name,
    "size": item.size,
    "icon": item.icon,
    "link": item.link,
    "pages": item.pages,
    "subTag1": item.subTag1,
    "subTag2": item.subTag2,
    "isPrime": item.isPrime
  };

  static String encode(List<NotesItem> items) => json.encode(
    items
        .map<Map<String, dynamic>>((item) => NotesItem.toMap(item))
        .toList(),
  );

  static List<NotesItem> decode(String items) =>
      (json.decode(items) as List<dynamic>)
          .map<NotesItem>((item) => NotesItem.fromJson(item))
          .toList();

  @override
  List<Object?> get props => [
    id,
    name,
    size,
    icon,
    link
  ];
}