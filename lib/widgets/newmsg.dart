import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:provider/provider.dart';


class NewMessage extends StatefulWidget {
  Contect_Model contect_model;
  NewMessage(this.contect_model);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
   _controller.clear();
     Provider.of<Api_provider>(context ,listen: false).GetLastMsg(_enteredMessage, DateTime.now());
  await Provider.of<Api_provider>(context ,listen: false).addmsg(_enteredMessage, widget. contect_model);
    Provider.of<Api_provider>(context ,listen: false).lastmsgInList=null;
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                
                controller: _controller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: BorderSide(width: 1.w,color: Theme.of(context).primaryColor)),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: BorderSide(width: 1.w,color: Theme.of(context).primaryColor)),
                  
                  hintText: 'Send a message...'),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              size:40.sp ,
              Icons.send,color: Colors.white,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
