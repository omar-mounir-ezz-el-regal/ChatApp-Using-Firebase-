import 'package:chat_try_3/blocs/chat_bloc/chat_cubit.dart';
import 'package:chat_try_3/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/chat_bloc/chat_states.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    ChatCubit cubit = ChatCubit.get(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: cubit.users.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
            await cubit.getAllMessages(index);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(index: index),
                ));
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  BlocConsumer<ChatCubit, ChatStates>(
                    listener: (c, s) {},
                    builder: (context, state) => ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        radius: 30,
                        child: Image.network("${cubit.users[index].photoUrl}"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("${cubit.users[index].name}")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
