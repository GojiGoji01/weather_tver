import 'package:bless_clicker/user.dart';
import 'package:bless_clicker/user_detscreen.dart';
import 'package:flutter/material.dart';

class NumbersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' numbers'),
      ),
      body: NumbersList(),
    );
  }
}

class NumbersList extends StatelessWidget {
  final List<User> predefinedUsers = [
    User(
      name: 'Jeka Sivitskiy',
      phoneNumber: '+79999939393',
      avatar: 'assets/joka.jpg',
      rate: 4.5,
      likes: 2836,
      photos: [
        'assets/joka1.jpg',
        'assets/joka2.jpg',
        'assets/joka3.jpg',
      ],
      friends: 648,
      subs: 10546,
      status:
          ' dunno what u wwhant dunno what dunno what u wwhant dunno what u dunno what u wwhant dunno what uu wwhant dunno what u wwhant  ',
    ),
    User(
      name: 'Vasya',
      phoneNumber: '+79599930505',
      avatar: 'assets/joka.jpg',
      rate: 4.9,
      likes: 9330,
      photos: [
        'assets/pob.jpg',
        'assets/pob.jpg',
        'assets/pob.jpg',
      ],
      friends: 1610,
      subs: 10890,
      status: 'chort',
    ),
    User(
      name: 'Goji',
      phoneNumber: '+79993434677',
      avatar: 'assets/pob.jpg',
      rate: 4.9,
      likes: 6360,
      photos: [],
      friends: 630,
      subs: 10440,
      status: 'EBY MALOLETOK i MAM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // это список мы задаем ему какой длины будет список
      itemCount: predefinedUsers.length, // вот длина списка
      itemBuilder: (context, index) {
        // он предлагает задать данные через функцию
        //он вызовет по идексу 0  и до конца списка
        final user = predefinedUsers[index]; //
        return ListTile(
          // элемент списка
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserDetailsScreen(user: user))),
          leading: CircleAvatar(foregroundImage: AssetImage(user.avatar)),
          title: Text(user.name),
          subtitle: Text(user.phoneNumber),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star,
                  size: 32, color: const Color.fromARGB(255, 71, 70, 55)),
              SizedBox(width: 30),
              Text(user.rate.toString()),
            ],
          ),
        );
      },
    );
  }
}
// описание детальное ( кол во лайков рейтинг статус номер  количество друзей подписчиков
// фотки)
