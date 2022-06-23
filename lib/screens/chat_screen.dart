import 'package:chat_try_3/blocs/chat_bloc/chat_cubit.dart';
import 'package:chat_try_3/colors.dart';
import 'package:chat_try_3/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/chat_bloc/chat_states.dart';

class ChatScreen extends StatefulWidget {
  final int index;
  const ChatScreen({Key? key, required this.index}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    ChatCubit cubit = ChatCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: w,
            height: h,
            color: first,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  height: h * .8,
                  child: BlocConsumer<ChatCubit, ChatStates>(
                    listener: (c, s) {},
                    builder: (c, s) => ListView.builder(
                      itemCount: cubit.allMessages.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          textDirection: (cubit.registeredUser.id ==
                                  cubit.allMessages[index].recieverId)
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CircleAvatar(
                                    child: Image.asset("images/p4.jpg",
                                        fit: BoxFit.cover),
                                    radius: 20)),
                            const SizedBox(
                              width: 5,
                            ),
                            Chip(
                                label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${cubit.allMessages[index].title}"),
                                Text(
                                  "${cubit.allMessages[index].time}",
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFieldWidget(
                          controller: msgController,
                          secure: false,
                          suffixIcon: Icons.message,
                          hintText: "Enter Message",
                          keyBoardType: TextInputType.text),
                      FloatingActionButton(
                        onPressed: () async {
                          if (msgController.text.trim().length > 0) {
                            await cubit.sendMessage(
                                msgController.text, widget.index);
                            msgController.clear();
                          }
                        },
                        child: const Icon(Icons.send),
                        mini: true,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
