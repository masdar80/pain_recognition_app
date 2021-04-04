import 'package:flutter/material.dart';
import 'package:paintrecognition/classes/Settings.dart';


class MyDrawer extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Setting conf= new Setting();



  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text("info@e-namla.com"),
          accountName: Text(
            "Pain Recognition",
          ),
          currentAccountPicture: CircleAvatar(
            child: Icon(
              Icons.person,
              color: Colors.deepPurple.withOpacity(0.8),
            ),
            foregroundColor: Colors.deepPurple.withOpacity(0.5),
          ),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.5),
          ),
        ),
        ListTile(
          title: Text(
            " الرئيسية",
            style: TextStyle(
                color: Colors.deepPurple.withOpacity(0.9), fontSize: 20),
          ),
          leading: Icon(Icons.home, color: Colors.deepPurple.withOpacity(0.5)),
          onTap: () {
            Navigator.of(context).pushNamed('homepage');
          },
        ),
        ListTile(
          title: Text(
            "قياس درجة الالم",
            style: TextStyle(
                color: Colors.deepPurple.withOpacity(0.9), fontSize: 20),
          ),
          leading:
              Icon(Icons.bar_chart, color: Colors.deepPurple.withOpacity(0.5)),
          onTap: () {
            Navigator.of(context).pushNamed('pain_measurement');
          },
        ),
        ListTile(
          title: Text(
            "سجل المراجعين",
            style: TextStyle(
                color: Colors.deepPurple.withOpacity(0.9), fontSize: 20),
          ),
          leading: Icon(Icons.library_books_sharp,
              color: Colors.deepPurple.withOpacity(0.5)),
          onTap: () {
            Navigator.of(context).pushNamed('patientrest');
          },
        ),
        ListTile(
          title: Text(
            "اعدادات المخدم",
            style: TextStyle(
                color: Colors.deepPurple.withOpacity(0.9), fontSize: 20),
          ),
          leading: Icon(Icons.library_books_sharp,
              color: Colors.deepPurple.withOpacity(0.5)),
          onTap: () async {


            await showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                    title: Center(child: Text("اعدادات المخدم")),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: Container(
                        height: 155,
                        child: new Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                initialValue: Setting.getServerIP(),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.url,
                                decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: 'عنوان المخدم'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'لا يمكن حفظ عنوان مخدم فارغ';
                                  } else {
                                   //  conf.setServerIP(value);
                                     conf.saveMyIP(value);
                                  //  Setting.Settings().server_ip=value;
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false
                                      // otherwise.
                                      if (_formKey.currentState.validate()) {
                                        print("save");
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text('حفظ'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))));

            // Doesn't run
           // Navigator.pop(context);

            // Doesn't run
            // Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "حول البرنامج",
            style: TextStyle(
                color: Colors.deepPurple.withOpacity(0.9), fontSize: 20),
          ),
          leading: Icon(Icons.help_outlined,
              color: Colors.deepPurple.withOpacity(0.5)),
          onTap: () {
            Navigator.of(context).pushNamed('patientrest');
          },
        )
      ],
    ));
  }
}
