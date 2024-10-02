import 'package:drive2go/Bloc/SendMessage_Bloc/send_message_bloc.dart';
import 'package:drive2go/Bloc/ShowSendMessage_Bloc/show_send_message_bloc.dart';
import 'package:drive2go/Repository/ModelClass/ProfileModels/HelpChatModels/SendMessageModel.dart';
import 'package:drive2go/Repository/ModelClass/ProfileModels/HelpChatModels/ShowSendMessageModel.dart';
import 'package:drive2go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Repository/ModelClass/ProfileModels/HelpChatModels/ShowSendMessageModel.dart';

class HelpChatPage extends StatefulWidget {
  const HelpChatPage({super.key});

  @override
  State<HelpChatPage> createState() => _HelpChatPageState();
}

class _HelpChatPageState extends State<HelpChatPage> {
  @override
  void initState() {
    BlocProvider.of<ShowSendMessageBloc>(context).add(FeatchShowSendMessage());
    super.initState();
  }

  TextEditingController sendmessageconteoller = TextEditingController();
  late SendMessageModel sendMessageModel;
  late List<ShowSendMessageModel> showMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomSheet: Container(
        width: double.infinity.w,
        height: 80.h,
        color: Colors.black,
        child: Row(
          children: [
            SizedBox(
              height: 70.h,
              width: 360.w,
              child: TextField(
                controller: sendmessageconteoller,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.blueGrey,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            BlocListener<SendMessageBloc, SendMessageState>(
              listener: (context, state) {
                if (state is SendMessageBlocLoading) {
                  print("siginloading");
                }
                if (state is SendMessageBlocError) {
                  print('error');
                }
                if (state is SendMessageBlocLoaded) {
                  BlocProvider.of<ShowSendMessageBloc>(context)
                      .add(FeatchShowSendMessage());
                  sendMessageModel = BlocProvider.of<SendMessageBloc>(context)
                      .sendMessageModel;
                  sendmessageconteoller.clear();
                }
              },
              child: InkWell(
                onTap: () {
                  BlocProvider.of<SendMessageBloc>(context).add(
                      FeatchSendMeassage(
                          Description: sendmessageconteoller.text));
                },
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.send),
                ),
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<ShowSendMessageBloc, ShowSendMessageState>(
          builder: (context, state) {
        if (state is ShowSendMessageBlocLoading) {
          print("loading");
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShowSendMessageBlocError) {
          print("error");
          return Center(
            child: Text(
              "Error",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (state is ShowSendMessageBlocLoaded) {
          showMessage =
              BlocProvider.of<ShowSendMessageBloc>(context).showSendMessage;
          return ListView.builder(
            itemCount: showMessage.length,
            itemBuilder: (BuildContext context, int index) {

              return
                showMessage[index].queryDescription==0? SizedBox():Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  ChatBubble(
                    clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                    alignment: Alignment.topRight,
                    backGroundColor: Colors.blue,
                    child: Text(
                      showMessage[index].queryDescription.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  showMessage[index].response == null
                      ? SizedBox()
                      : ChatBubble(
                          clipper: ChatBubbleClipper1(
                              type: BubbleType.receiverBubble),
                          backGroundColor: Color(0xffE7E7ED),
                          child: Text(
                            showMessage[index].response.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              );
            },
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
