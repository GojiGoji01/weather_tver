import 'package:bless_clicker/user.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Container(
                color: Colors.black,
                height: 180,
                width: 400,
                child: Center(
                  child: Image.asset(
                    user.avatar,
                    height: 240,
                    width: 250,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 17),
                  Text(
                    user.phoneNumber,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17,
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Выравнивание по центру
                children: [
                  Icon(Icons.favorite, size: 32, color: Colors.red),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    user.likes.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.people,
                      size: 32, color: Color.fromARGB(255, 30, 73, 191)),
                  SizedBox(
                    width: 8,
                  ), // Пространство между текстовыми виджетами
                  Text(
                    user.friends.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.people_outline,
                      size: 32, color: Color.fromARGB(255, 30, 73, 191)),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    user.subs.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(user.status.toString()),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.photo_album,
                      size: 18, color: Color.fromARGB(255, 30, 73, 191)),
                  SizedBox(height: 16),
                  Text('МОИ ФОТОГРАФИИ '),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: user.photos.length,
                  itemBuilder: (context, index) =>
                      Image.asset(user.photos[index]),

                  scrollDirection: Axis.horizontal, // Vertical scroll direction
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
