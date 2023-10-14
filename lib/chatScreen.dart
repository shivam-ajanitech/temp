import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  List <dynamic> data = [['hi','received'],['hello','sent']];
  ScrollController _controller = new ScrollController();

  void PostMessage(String msg) async{
    var url = Uri.https('slaychatgpt.com','postmsg.php');
    var response = await http.post(url,body: {'sender': 'shivam', 'msg': msg});
    data.add([response.body.toString(),'received']);
    setState(() {

    });
  }
  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child:  AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){},
            ),
            SizedBox(width: 5,),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDV6AFwPlhFA0lutcscKiTdqI-7Mi8IDjrJeLArcE&s'),
                radius: 30,
              ),
            ),
            SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Text('Friends Group',style: TextStyle(
                    fontSize: 20,
                  ),),
                  Text('Rahul, Shivam, Avi',style: TextStyle(
                      fontSize: 14
                  ),),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,size: 30,))
          ],
        ),
      ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height*0.91,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Row(
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_rounded,color: Colors.grey[500],)),
                              SizedBox(width: 5,),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Type message here...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  onSubmitted: (String value){
                                    setState(() {
                                      data.add([value,'sent']);
                                    });
                                    PostMessage(value);

                                  },

                                ),
                              ),
                              SizedBox(width: 5,),
                              IconButton(onPressed: _scrollDown, icon: Icon(Icons.attach_file,color: Colors.grey[500],)),
                              SizedBox(width: 5,),
                              IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt,color: Colors.grey[500],))
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(Icons.mic,color: Colors.blue,),
                            onPressed: (){},
                          ),
                          radius: 30,
                        )
                      ],

                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[200]
                        ),
                        child: ListView.builder(
                            itemCount: 10,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return Container(
                                padding: EdgeInsets.all(5),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: index%2==0?Colors.lightGreen:Colors.grey[200],
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDV6AFwPlhFA0lutcscKiTdqI-7Mi8IDjrJeLArcE&s'),
                                    radius: 25,
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.75,
                        child: ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          controller: _controller,
                          itemBuilder: (context,index){
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: data[index][1]=='received'?
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDV6AFwPlhFA0lutcscKiTdqI-7Mi8IDjrJeLArcE&s'),
                                    radius: 15,
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.7,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.3),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.zero,
                                          topRight: Radius.circular(10),
                                          bottomRight:  Radius.circular(10),
                                          bottomLeft:  Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Rahul Sharma',style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[900],
                                        ),),
                                        Text(data[index][0]),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('8:00 AM', style: TextStyle(
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.w400
                                            ),),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ):
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.3),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.zero,
                                              bottomRight:  Radius.circular(10),
                                              bottomLeft:  Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Shivam',style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[900],
                                            ),),
                                            Text(data[index][0]),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text('8:00 AM', style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.w400
                                                ),),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 20,
                                        child: ListView.builder(
                                          itemCount: 4,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context,index){
                                            return CircleAvatar(
                                              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDV6AFwPlhFA0lutcscKiTdqI-7Mi8IDjrJeLArcE&s'),
                                              radius: 10,
                                            );
                                          },),
                                      )
                                    ],
                                  ),

                                ],
                              )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    ));
  }
}

