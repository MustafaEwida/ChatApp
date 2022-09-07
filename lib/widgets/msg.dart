import 'package:flutter/material.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/models/msgmodel.dart';

class MessageBubble extends StatelessWidget {
  bool islast  ;
    final Msg_model message;
  MessageBubble(
   {required this.message,this.islast=false }
  );




  @override
  Widget build(BuildContext context) {
     bool isMe = message.useriD ==Auth_helper.auth_helper.user!.id;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child:islast?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(
            message.text!,
            style: TextStyle(
              color: isMe
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          Icon(Icons.hourglass_bottom)
          ],) :Text(
            message.text!,
            style: TextStyle(
              color: isMe
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
